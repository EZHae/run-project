package com.itwill.running.web;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwill.running.domain.Park;
import com.itwill.running.repository.ParkDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/api/park")
public class ParkController {
	private final ParkDao parkDao;
	
	@GetMapping("/all")
	public ResponseEntity<List<Park>> getAllParks(){
		List<Park> parks=parkDao.selectAll();
		return ResponseEntity.ok(parks);
	}
	
	@GetMapping("/search")
	public ResponseEntity<List<Park>> getParksByParkLoc(@RequestParam String parkLoc){
		List<Park> parks=parkDao.selectParksByParkLoc(parkLoc);
		return ResponseEntity.ok(parks);
	}
	
	@GetMapping("/alllocs")
	public ResponseEntity<List<String>> getAllParkLocs(){
		List<String> parkLocs=parkDao.selectDistinctParkLocs();
		return ResponseEntity.ok(parkLocs);
	}
	
	// 25-02-12 이지해 추가: 선택한 공원 지도에 미리보기 표시
	@GetMapping("/search/{id}")
	public ResponseEntity<Park> getParkByParkId(@PathVariable Integer id) {
		Park park = parkDao.selectParkByParkId(id);
		return ResponseEntity.ok(park);
	}
}
