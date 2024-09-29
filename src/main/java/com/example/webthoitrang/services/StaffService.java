package com.example.webthoitrang.services;

import com.example.webthoitrang.entity.Staff;
import com.example.webthoitrang.repository.StaffRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StaffService {

    private final StaffRepository staffRepository;

    public StaffService(StaffRepository staffRepository) {
        this.staffRepository = staffRepository;
    }

    public Staff getStaffById(int staffId) {return staffRepository.findById(staffId).orElse(null);}

    public Staff addOrUpdateStaff(Staff staff) {return this.staffRepository.save(staff);}

    public List<Staff> getAllStaff() {return staffRepository.findAll();}
}
