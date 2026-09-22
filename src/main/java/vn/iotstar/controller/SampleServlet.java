package vn.iotstar.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import vn.iotstar.entity.Category;
import vn.iotstar.entity.Sample;
import vn.iotstar.service.ICategoryService;
import vn.iotstar.service.ISampleService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.SampleServiceImpl;

@WebServlet(urlPatterns = {"/sample", "/sample/*"})
public class SampleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ISampleService sampleService = new SampleServiceImpl();
    private final ICategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "list";
        }

        try {
            switch (action) {
                case "list":
                    handleList(req, resp);
                    break;
                case "detail":
                    handleDetail(req, resp);
                    break;
                case "add":
                    handleAddForm(req, resp);
                    break;
                case "edit":
                    handleEditForm(req, resp);
                    break;
                case "delete":
                    handleDelete(req, resp);
                    break;
                case "search":
                    handleSearch(req, resp);
                    break;
                case "filter":
                    handleFilter(req, resp);
                    break;
                default:
                    handleList(req, resp);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Đã xảy ra lỗi: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");
        if (action == null) {
            action = "save";
        }

        try {
            switch (action) {
                case "add":
                case "insert":
                    handleInsert(req, resp);
                    break;
                case "edit":
                case "update":
                    handleUpdate(req, resp);
                    break;
                default:
                    resp.sendRedirect(req.getContextPath() + "/sample?action=list");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Lỗi xử lý dữ liệu: " + e.getMessage());
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    private void handleList(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String pageStr = req.getParameter("page");
        int page = 1;
        int size = 5;

        if (pageStr != null && !pageStr.trim().isEmpty()) {
            try {
                page = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException ignored) {
            }
        }

        int totalItems = sampleService.count();
        int totalPages = (int) Math.ceil((double) totalItems / size);
        if (totalPages < 1) totalPages = 1;

        List<Sample> samples = sampleService.findPaginated(page, size);
        List<Category> categories = categoryService.findAll();

        req.setAttribute("samples", samples);
        req.setAttribute("categories", categories);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalItems", totalItems);

        req.getRequestDispatcher("/views/sample/sample-list.jsp").forward(req, resp);
    }

    private void handleDetail(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/sample?action=list&error=missing_id");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Sample sample = sampleService.findById(id);
            if (sample == null) {
                req.setAttribute("errorMessage", "Không tìm thấy dữ liệu có ID = " + id);
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }
            req.setAttribute("sample", sample);
            req.getRequestDispatcher("/views/sample/sample-detail.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "ID không hợp lệ: " + idStr);
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    private void handleAddForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Category> categories = categoryService.findAll();
        req.setAttribute("categories", categories);
        req.setAttribute("formAction", "add");
        req.setAttribute("pageTitle", "Thêm mới Sample");
        req.getRequestDispatcher("/views/sample/sample-form.jsp").forward(req, resp);
    }

    private void handleEditForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/sample?action=list&error=missing_id");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Sample sample = sampleService.findById(id);
            if (sample == null) {
                req.setAttribute("errorMessage", "Không tìm thấy dữ liệu có ID = " + id);
                req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
                return;
            }
            List<Category> categories = categoryService.findAll();
            req.setAttribute("sample", sample);
            req.setAttribute("categories", categories);
            req.setAttribute("formAction", "edit");
            req.setAttribute("pageTitle", "Chỉnh sửa Sample #" + id);
            req.getRequestDispatcher("/views/sample/sample-form.jsp").forward(req, resp);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "ID không hợp lệ: " + idStr);
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
        }
    }

    private void handleDelete(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                sampleService.delete(id);
                resp.sendRedirect(req.getContextPath() + "/sample?action=list&msg=delete_success");
                return;
            } catch (Exception e) {
                resp.sendRedirect(req.getContextPath() + "/sample?action=list&error=" + e.getMessage());
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/sample?action=list&error=missing_id");
    }

    private void handleSearch(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String keyword = req.getParameter("keyword");
        List<Sample> samples;
        if (keyword == null || keyword.trim().isEmpty()) {
            samples = sampleService.findAll();
        } else {
            samples = sampleService.search(keyword.trim());
        }
        List<Category> categories = categoryService.findAll();
        req.setAttribute("samples", samples);
        req.setAttribute("categories", categories);
        req.setAttribute("keyword", keyword);
        req.setAttribute("totalItems", samples.size());
        req.setAttribute("totalPages", 1);
        req.setAttribute("currentPage", 1);
        req.getRequestDispatcher("/views/sample/sample-list.jsp").forward(req, resp);
    }

    private void handleFilter(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String catIdStr = req.getParameter("category_id");
        String statusStr = req.getParameter("status");

        List<Sample> samples;
        if (catIdStr != null && !catIdStr.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(catIdStr);
                samples = sampleService.findByCategory(catId);
                req.setAttribute("selectedCategoryId", catId);
            } catch (NumberFormatException e) {
                samples = sampleService.findAll();
            }
        } else if (statusStr != null && !statusStr.trim().isEmpty()) {
            try {
                int status = Integer.parseInt(statusStr);
                samples = sampleService.findByStatus(status);
                req.setAttribute("selectedStatus", status);
            } catch (NumberFormatException e) {
                samples = sampleService.findAll();
            }
        } else {
            samples = sampleService.findAll();
        }

        List<Category> categories = categoryService.findAll();
        req.setAttribute("samples", samples);
        req.setAttribute("categories", categories);
        req.setAttribute("totalItems", samples.size());
        req.setAttribute("totalPages", 1);
        req.setAttribute("currentPage", 1);
        req.getRequestDispatcher("/views/sample/sample-list.jsp").forward(req, resp);
    }

    private void handleInsert(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String statusStr = req.getParameter("status");
        String categoryIdStr = req.getParameter("category_id");

        // Validation
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("validationError", "Tên (Name) không được để trống!");
            retainFormInput(req, name, description, statusStr, categoryIdStr);
            handleAddForm(req, resp);
            return;
        }

        int status = 1;
        try {
            if (statusStr != null) status = Integer.parseInt(statusStr);
        } catch (NumberFormatException ignored) {}

        Category category = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryIdStr);
                category = categoryService.findById(catId);
            } catch (NumberFormatException ignored) {}
        }

        Sample sample = new Sample(name.trim(), description != null ? description.trim() : "", status, category);
        sampleService.insert(sample);

        resp.sendRedirect(req.getContextPath() + "/sample?action=list&msg=add_success");
    }

    private void handleUpdate(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String statusStr = req.getParameter("status");
        String categoryIdStr = req.getParameter("category_id");

        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/sample?action=list&error=missing_id");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/sample?action=list&error=invalid_id");
            return;
        }

        // Validation
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("validationError", "Tên (Name) không được để trống!");
            retainFormInput(req, name, description, statusStr, categoryIdStr);
            Sample existing = new Sample(name, description, 1, null);
            existing.setId(id);
            req.setAttribute("sample", existing);
            List<Category> categories = categoryService.findAll();
            req.setAttribute("categories", categories);
            req.setAttribute("formAction", "edit");
            req.setAttribute("pageTitle", "Chỉnh sửa Sample #" + id);
            req.getRequestDispatcher("/views/sample/sample-form.jsp").forward(req, resp);
            return;
        }

        int status = 1;
        try {
            if (statusStr != null) status = Integer.parseInt(statusStr);
        } catch (NumberFormatException ignored) {}

        Category category = null;
        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                int catId = Integer.parseInt(categoryIdStr);
                category = categoryService.findById(catId);
            } catch (NumberFormatException ignored) {}
        }

        Sample sample = sampleService.findById(id);
        if (sample == null) {
            req.setAttribute("errorMessage", "Không tìm thấy bản ghi cần sửa có ID = " + id);
            req.getRequestDispatcher("/views/error.jsp").forward(req, resp);
            return;
        }

        sample.setName(name.trim());
        sample.setDescription(description != null ? description.trim() : "");
        sample.setStatus(status);
        sample.setCategory(category);

        sampleService.update(sample);

        resp.sendRedirect(req.getContextPath() + "/sample?action=list&msg=update_success");
    }

    private void retainFormInput(HttpServletRequest req, String name, String description, String statusStr, String categoryIdStr) {
        req.setAttribute("retainedName", name);
        req.setAttribute("retainedDescription", description);
        req.setAttribute("retainedStatus", statusStr);
        req.setAttribute("retainedCategoryId", categoryIdStr);
    }
}
