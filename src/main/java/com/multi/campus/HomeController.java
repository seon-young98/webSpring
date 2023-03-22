package com.multi.campus;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller //annotation -> Controller, RestController
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET) //get방식
	public String home(Model model) {
		//매개변수에 Model변수를 선언하고 Model에 필요한 데이터를 세팅하면 뷰페이지에서 사용가능하다.
		model.addAttribute("num",1234);
		model.addAttribute("name","김선영");
		return "home";
	}
}