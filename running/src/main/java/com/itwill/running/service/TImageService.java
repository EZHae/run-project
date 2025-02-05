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
		
		List<TImage> images = imageDao.selectTImageByPostId(postId);
		log.debug("# of loadImages() result = {}", images.size());
		
		return images;
	}
	
	public List<TImage> readByAll() {
		log.debug("TImageService::readByAll");
		
		List<TImage> images = imageDao.selectTimageByAll();
		log.debug("# of readByAll() result = {}", images.size());
		
		return images;
	}
	
	public List<TImage> readByTeamId(Integer teamId) {
		log.debug("TImageService::readByTeamId");
		
		List<TImage> images = imageDao.selectTImageByTeamId(teamId);
		log.debug("# of readByTeamId() result = {}", images.size());
		
		return images;
	}
	
	public List<TImage> readByTeamIdAndNotNull(Integer teamId) {
		log.debug("TImageService::readByTeamIdAndNotNull");
		
		List<TImage> images = imageDao.selectTimageByTeamIdAndNotNull(teamId);
		log.debug("# of readByTeamIdAndNotNull() result = {}", images.size());
		
		return images;
	}
	
	public List<TImage> readByTeamIdAndNull(Integer teamId) {
		log.debug("TImageService::readByTeamIdAndNull");
		
		List<TImage> images = imageDao.selectTImageByTeamIdAndNull(teamId);
		log.debug("# of readByTeamIdAndNull() result = {}", images.size());
		
		return images;
	}
	
	public void deleteByPostId(Integer postId) {
		log.debug("TImageService::delete(postId={})", postId);
		
		imageDao.deleteTImageByPostId(postId);
	}
	
	public void deleteById(Integer id) {
		log.debug("TImageService::delete(id={})", id);
		
		imageDao.deleteTImageById(id);
		
	}
}
