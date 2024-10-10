/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.reservation.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.example.sample.reservation.service.ReservationService;
import egovframework.example.sample.reservation.service.ReservationVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * @Class Name : EgovSampleServiceImpl.java
 * @Description : Sample Business Implement Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Service("reservationService")
public class ReservationServiceImpl extends EgovAbstractServiceImpl implements ReservationService {

	private static final Logger LOGGER = LoggerFactory.getLogger(ReservationServiceImpl.class);

	/** SampleDAO */
	// TODO ibatis 사용
//	@Resource(name = "sampleDAO")
//	private SampleDAO sampleDAO;
	// TODO mybatis 사용
	  @Resource(name="reservationMapper")
		private ReservationMapper reservationDAO;

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;

	/**
	 * 글을 등록한다.
	 * @param vo - 등록할 정보가 담긴 SampleVO
	 * @return 등록 결과
	 * @exception Exception
	 */
	@Override
	public String insertBoard(ReservationVO vo) throws Exception {
		LOGGER.debug(vo.toString());

		/** ID Generation Service */
//		String id = egovIdGnrService.getNextStringId();
//		vo.setId(id);
//		LOGGER.debug(vo.toString());

		reservationDAO.insertBoard(vo);
		return vo.getIdx();
	}

	/**
	 * 글을 수정한다.
	 * @param vo - 수정할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void updateBoard(ReservationVO vo) throws Exception {
		reservationDAO.updateBoard(vo);
	}
	
	public void updateBoardCount(ReservationVO vo) throws Exception {
		reservationDAO.updateBoardCount(vo);
	}

	/**
	 * 글을 삭제한다.
	 * @param vo - 삭제할 정보가 담긴 SampleVO
	 * @return void형
	 * @exception Exception
	 */
	@Override
	public void deleteBoard(ReservationVO vo) throws Exception {
		reservationDAO.deleteBoard(vo);
	}

	/**
	 * 글을 조회한다.
	 * @param vo - 조회할 정보가 담긴 SampleVO
	 * @return 조회한 글
	 * @exception Exception
	 */
	@Override
	public ReservationVO selectBoard(ReservationVO vo) throws Exception {
		ReservationVO resultVO = reservationDAO.selectBoard(vo);
		if (resultVO == null) {
			resultVO = new ReservationVO();
		}
//			throw processException("info.nodata.msg");
		return resultVO;
	}
	

	/**
	 * 글 목록을 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 목록
	 * @exception Exception
	 */
	@Override
	public List<?> selectBoardList(ReservationVO searchVO) throws Exception {
		return reservationDAO.selectBoardList(searchVO);
	}

	/**
	 * 글 총 갯수를 조회한다.
	 * @param searchVO - 조회할 정보가 담긴 VO
	 * @return 글 총 갯수
	 * @exception
	 */
	@Override
	public int selectBoardListTotCnt(ReservationVO searchVO) {
		return reservationDAO.selectBoardListTotCnt(searchVO);
	}

	@Override
	public int insertBooking(ReservationVO vo) throws Exception {
		LOGGER.debug(vo.toString());
		
		reservationDAO.insertBooking(vo);
		return vo.getReservation_id();
	}
	
	public ReservationVO selectBooking(ReservationVO vo) throws Exception{
	    // 로그 추가
	    System.out.println("Reservation ID: " + vo.getReservation_id());
	    // 데이터베이스에서 값을 가져오는 로직
	    ReservationVO result = reservationDAO.selectBooking(vo);
	    // 로그 추가
	    System.out.println("Retrieved Reservation: " + result);
	    return result;
	}


	@Override
	public void deleteBooking(ReservationVO vo) throws Exception {
		reservationDAO.deleteBooking(vo);
		
	}

	@Override
	public List<ReservationVO> selectBookingList(ReservationVO ReservationVO) throws Exception{
		return reservationDAO.selectBookingList(ReservationVO);
	}
	
	public String selectLoginCheck(ReservationVO searchVO) {
		return reservationDAO.selectLoginCheck(searchVO);
	}

	@Override
	public int getNextReservationIdx(ReservationVO searchVO) throws Exception{	
		return reservationDAO.getNextReservationIdx(searchVO);
	}
	
	


}
