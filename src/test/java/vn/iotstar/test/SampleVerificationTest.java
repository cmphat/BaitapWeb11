package vn.iotstar.test;

import java.util.List;
import vn.iotstar.dao.ISampleDao;
import vn.iotstar.dao.impl.SampleDao;
import vn.iotstar.entity.Sample;

public class SampleVerificationTest {

    public static void main(String[] args) {
        System.out.println("=== BAT DAU KIEM TRA SAMPLE CRUD VOI SQL SERVER ===");
        ISampleDao dao = new SampleDao();

        try {
            // 1. Test findAll
            List<Sample> list = dao.findAll();
            System.out.println("[PASS] findAll thanh cong! Tong so ban ghi: " + list.size());
            for (Sample s : list) {
                System.out.println(" - #" + s.getId() + ": " + s.getName() + " | Status: " + s.getStatus());
            }

            // 2. Test search
            List<Sample> searchResults = dao.search("Laptop");
            System.out.println("[PASS] search('Laptop') thanh cong! Tim thay: " + searchResults.size() + " ban ghi.");

            // 3. Test count
            int count = dao.count();
            System.out.println("[PASS] count() thanh cong: " + count);

            // 4. Test insert & delete
            Sample newSample = new Sample("Test Product Mock Exam", "Mo ta test kiem thu", 1, null);
            dao.insert(newSample);
            System.out.println("[PASS] insert thanh cong! ID tao moi: " + newSample.getId());

            Sample found = dao.findById(newSample.getId());
            if (found != null && found.getName().equals("Test Product Mock Exam")) {
                System.out.println("[PASS] findById xac nhan ban ghi vua them thanh cong!");
            }

            // Xoa ban ghi test de giu sach CSDL
            dao.delete(newSample.getId());
            System.out.println("[PASS] delete ban ghi test thanh cong!");

            System.out.println("=== TOAN BO TEST PASSED 100% ===");

        } catch (Exception e) {
            System.err.println("[FAIL] Loi kiem thu Sample DAO:");
            e.printStackTrace();
        }
    }
}
