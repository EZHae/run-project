package com.itwill.running.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.itwill.running.domain.TImage;
import com.itwill.running.repository.TImageDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TImageService {

	private final TImageDao imageDao;
	
	public void saveImages(List<TImage> images) {
		log.debug("TImageService::saveImages");
		log.debug("# of saveImages() result = {}", images.size());
		
		for (TImage image : images) {
			imageDao.insertTImage(image);
		}
	}
	
	public List<TImage> loadImage(Integer postId) {
		log.debug("TImageService::loadImages");
		
		List<TImage> images = imageDao.selectTImagesByPostId(postId);
		log.debug("# of loadImages() result = {}", images.size());
		
		return images;
	}
	
	public void delete(Integer postId) {
		log.debug("TImageService::delete(postId={})", postId);
		
		imageDao.deleteTImageByPostId(postId);
	}
}
