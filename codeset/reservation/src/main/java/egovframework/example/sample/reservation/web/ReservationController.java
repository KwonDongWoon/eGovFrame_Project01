package egovframework.example.sample.reservation.web;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.example.sample.reservation.service.ReservationService;
import egovframework.example.sample.reservation.service.ReservationVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ReservationController {
	
	@Resource(name="reservationService")
	private ReservationService reservationService;
	

	// 홈화면
	@RequestMapping(value = "/home.do")
	public String home(ModelMap model) throws Exception {
		return "reservation/home";
	}
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	// 공지사항
	@RequestMapping(value = "/announcement.do")
	public String announcement(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model) throws Exception {
		/** EgovPropertyService.sample */
		reservationVO.setPageUnit(propertiesService.getInt("pageUnit"));
		reservationVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(reservationVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(reservationVO.getPageUnit());
		paginationInfo.setPageSize(reservationVO.getPageSize());

		reservationVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		reservationVO.setLastIndex(paginationInfo.getLastRecordIndex());
		reservationVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<?> list = reservationService.selectBoardList(reservationVO);
		model.addAttribute("resultList", list);
		
		int totCnt = reservationService.selectBoardListTotCnt(reservationVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "reservation/announcement";
	}

	// 등록화면
	@RequestMapping(value = "/mgmg.do", method =RequestMethod.GET)
	public String mgmg(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model, HttpServletRequest request) throws Exception {
	     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
	     Calendar c1 = Calendar.getInstance();
	     String strToday = sdf.format(c1.getTime());
	     System.out.println("Today" + strToday);

	     reservationVO.setIndate(strToday);
	     reservationVO.setWriter(request.getSession().getAttribute("userId").toString());
	     reservationVO.setWriterNm(request.getSession().getAttribute("userName").toString());

	// 서버에서 가져오기
	if(request.getAttribute("idx") != null) {
		reservationVO = reservationService.selectBoard(reservationVO);
	     model.addAttribute("reservationVO", reservationVO);
	} // 서버에서 가져온 값을 화면에 맵핑

	return "reservation/mgmg";
	}

	@RequestMapping(value = "/mgmg.do", method=RequestMethod.POST)
	public String mgmg2(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model) throws Exception {
		reservationService.insertBoard(reservationVO);
	return "redirect:/announcement.do";
	}

	
	// 등록 수정 화면
	@RequestMapping(value = "/mgmt.do", method=RequestMethod.GET)
	public String mgmt(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model, HttpServletRequest request) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		System.out.println("Today" + strToday);

		// BoardVO boardVO = new BoardVO();
		reservationVO.setIndate(strToday);
		reservationVO.setWriter(request.getSession().getAttribute("userId").toString());
		reservationVO.setWriterNm(request.getSession().getAttribute("userName").toString());
		
		// 서버에서 가져오기
		reservationVO = reservationService.selectBoard(reservationVO);

		// 서버에서 가져온값을 화면에 맵핑
		model.addAttribute("reservationVO", reservationVO);
		
		return "reservation/mgmt";
	}
	
	@RequestMapping(value = "/mgmt.do", method = RequestMethod.POST)
	public String mgmt2(@ModelAttribute("reservationVO") ReservationVO reservationVO, 
			@RequestParam("mode") String mode, ModelMap model) throws Exception {
		if ("add".equals(mode)) {
			reservationService.insertBoard(reservationVO);
		} else if ("modify".equals(mode)) {
			reservationService.updateBoard(reservationVO);
		} else if ("del".equals(mode)) {
			reservationService.deleteBoard(reservationVO);
		}
		return "redirect:/announcement.do";
	}
	

	// 게시글 조회 화면
	@RequestMapping(value = "/view.do")
	public String view(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model) throws Exception {
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar c1 = Calendar.getInstance();
		String strToday = sdf.format(c1.getTime());
		System.out.println("Today" + strToday);
		
		reservationService.updateBoardCount(reservationVO);
		
		reservationVO = reservationService.selectBoard(reservationVO);
		model.addAttribute("reservationVO", reservationVO);
		model.addAttribute("strToday", strToday);
		
		return "reservation/view";
	}
	
	
	public String selectLoginCheck(ReservationVO searchVO) {
		return reservationService.selectLoginCheck(searchVO);
	}

	
	// 로그인화면
	@RequestMapping(value = "/login.do")
	public String login(@RequestParam("user_id") String user_id,
	                    @RequestParam("password") String password,
	                    @RequestParam("email") String email,
	                    ModelMap model,
	                    HttpServletRequest request) throws Exception {

	    System.out.println("user_id: " + user_id);
	    System.out.println("password: " + password);
	    System.out.println("email: " + email);
	    
	    ReservationVO reservationVO = new ReservationVO();
	    reservationVO.setUser_id(user_id);
	    reservationVO.setPassword(password);
	    reservationVO.setEmail(email);
	    
	    String user_name = reservationService.selectLoginCheck(reservationVO);
	    System.out.println("Returned user_name: " + user_name);

	    if (user_name != null && !"".equals(user_name)) {
	        request.getSession().setAttribute("userId", user_id);
	        request.getSession().setAttribute("userName", user_name);
	        return "redirect:home.do"; // 로그인 성공 시 홈으로 리다이렉트
	    } else {
	        model.addAttribute("msg", "사용자 정보가 올바르지 않습니다.");
	        return "reservation/login"; // 로그인 실패 시 다시 로그인 페이지로
	    }
	}


	//로그아웃
	@RequestMapping(value = "/logout.do")
	public String logout(ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
		return "redirect:home.do";
	}	
	
	 // 예약 캘린더 예약 리스트 값 들고오기
    @RequestMapping(value = "/calender.do", method = RequestMethod.GET)
    public String calender(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model) throws Exception {
        List<ReservationVO> list = reservationService.selectBookingList(reservationVO);
        model.addAttribute("list", list);
        return "reservation/calender";
    }

    // 예약 정보 입력 화면 표시
    @RequestMapping(value = "/booking.do", method = RequestMethod.GET)
    public String booking(@ModelAttribute("reservationVO") ReservationVO reservationVO, @RequestParam("date") String date, ModelMap model) {
        try {
            int reservationIdx = reservationService.getNextReservationIdx(reservationVO); // 예약 번호 부여 로직
            model.addAttribute("reservationIdx", reservationIdx);
            model.addAttribute("reservationVO", new ReservationVO());
            model.addAttribute("date", date);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "예약 번호 부여 중 오류가 발생했습니다.");
            return "error-page"; // 에러 페이지로 이동
        }
        return "reservation/booking"; // booking.jsp로 이동
    }
    
    @RequestMapping(value = "/booking.do", method = RequestMethod.POST)
    public String booking2(@ModelAttribute("reservationVO") ReservationVO reservationVO, @RequestParam("start_time_full") String startTimeFull,
                           @RequestParam("end_time_full") String endTimeFull, RedirectAttributes redirectAttributes) {
        try {
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

            LocalDateTime startDateTime = LocalDateTime.parse(startTimeFull, dateTimeFormatter);
            LocalDateTime endDateTime = LocalDateTime.parse(endTimeFull, dateTimeFormatter);

            reservationVO.setStart_time(startDateTime.toString());
            reservationVO.setEnd_time(endDateTime.toString());

            reservationService.insertBooking(reservationVO); // 예약 정보 삽입 서비스 호출
            redirectAttributes.addFlashAttribute("reservationVO", reservationVO);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "예약 처리 중 오류가 발생했습니다. " + e.getMessage());
            return "redirect:/booking.do?date=" + startTimeFull.substring(0, 10);
        }
        return "redirect:/calender.do";
    }
    
    @RequestMapping(value = "/bookingView.do", method = RequestMethod.GET)
    public String bookingView(@RequestParam("reservation_id") int reservation_id, ModelMap model) throws Exception {
        ReservationVO reservationVO = new ReservationVO();
        reservationVO.setReservation_id(reservation_id);

        reservationVO = reservationService.selectBooking(reservationVO);
        if (reservationVO == null) {
            // 예외 처리 또는 에러 메시지 설정
            model.addAttribute("errorMessage", "예약 정보를 찾을 수 없습니다.");
        } else {
            model.addAttribute("reservationVO", reservationVO);
        }

        return "reservation/bookingView"; // bookingView.jsp로 이동
    }
    
    
    //삭제 버튼 누를시 테이블에 넣어진 데이터 삭제 실행
    @RequestMapping(value = "/bookingView.do", method=RequestMethod.POST)
    public String bookingView2(@ModelAttribute("reservationVO") ReservationVO reservationVO, ModelMap model)throws Exception {
    	try {
    		reservationService.deleteBooking(reservationVO);
    	}catch(Exception e) {
    		model.addAttribute("error", "에약 삭제 중 오류가 발생했습니다.");
    		return "error-page";
    	}
        return "redirect:/calender.do"; 
    }
}



