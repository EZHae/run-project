package com.itwill.running.domain;



import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Park {
	private Integer id;
	private String parkName;
	private String parkType;
	private String parkLoc;
	private Double parkLng;
	private Double parklat;
}
