package com.aug.controllers;

import java.io.IOException;
import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Hibernate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

// import services.MasDegreeTypeServiceTest;


import com.aug.hrdb.dto.AbilityDto;
import com.aug.hrdb.dto.AddressDto;
import com.aug.hrdb.dto.ApplicantDto;
import com.aug.hrdb.dto.CertificationDto;
import com.aug.hrdb.dto.EducationDto;
import com.aug.hrdb.dto.EmployeeDto;
import com.aug.hrdb.dto.ExperienceDto;
import com.aug.hrdb.dto.FamilyDto;
import com.aug.hrdb.dto.LanguageDto;
import com.aug.hrdb.dto.ReferenceDto;
import com.aug.hrdb.dto.ReportApplicantDto;
import com.aug.hrdb.dto.SearchReportDto;
import com.aug.hrdb.entities.Ability;
import com.aug.hrdb.entities.Address;
import com.aug.hrdb.entities.Applicant;
import com.aug.hrdb.entities.Certification;
import com.aug.hrdb.entities.Education;
import com.aug.hrdb.entities.Employee;
import com.aug.hrdb.entities.Experience;
import com.aug.hrdb.entities.Family;
import com.aug.hrdb.entities.Language;
import com.aug.hrdb.entities.Login;
import com.aug.hrdb.entities.MasAddressType;
import com.aug.hrdb.entities.MasDegreetype;
import com.aug.hrdb.entities.MasDivision;
import com.aug.hrdb.entities.MasJoblevel;
import com.aug.hrdb.entities.MasProvince;
import com.aug.hrdb.entities.MasRelationType;
import com.aug.hrdb.entities.MasSpecialty;
import com.aug.hrdb.entities.MasTechnology;
import com.aug.hrdb.entities.Reference;
import com.aug.hrdb.services.AbilityService;
import com.aug.hrdb.services.AddressService;
import com.aug.hrdb.services.ApplicantService;
import com.aug.hrdb.services.CertificationService;
import com.aug.hrdb.services.EducationService;
import com.aug.hrdb.services.EmployeeService;
import com.aug.hrdb.services.ExperienceService;
import com.aug.hrdb.services.FamilyService;
import com.aug.hrdb.services.LanguageService;
import com.aug.hrdb.services.LoginService;
import com.aug.hrdb.services.MasAddressTypeService;
import com.aug.hrdb.services.MasDegreetypeService;
import com.aug.hrdb.services.MasDivisionService;
import com.aug.hrdb.services.MasJoblevelService;
import com.aug.hrdb.services.MasProvinceService;
import com.aug.hrdb.services.MasRelationTypeService;
import com.aug.hrdb.services.MasSpecialtyService;
import com.aug.hrdb.services.MasTechnologyService;
import com.aug.hrdb.services.ReferenceService;
import com.aug.services.DownloadService;
import com.aug.services.ReportService;
import com.aug.services.UploadService;

import net.sf.jasperreports.engine.JRParameter;

@Controller
// @SessionAttributes("applicant")
public class ApplicantController implements Serializable {

	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = LoggerFactory.getLogger(ApplicantController.class);

	@Autowired
	private ApplicantService applicantService;
//	@Autowired
//	private PositionService positionService;
/*	@Autowired
	private ReportService reportService;*/
//	@Autowired
//	private DepartmentService departmentService;
	@Autowired
	private UploadService uploadService;
	@Autowired
	private ReferenceService referenceService;
	@Autowired
	private AddressService addressService;
	@Autowired
	private ExperienceService experienceService;
	@Autowired
	private EducationService educationService;
	@Autowired
	private LanguageService languageService;
	@Autowired
	private CertificationService certificationService;
	@Autowired
	private FamilyService familyService;
	@Autowired
	private PositionEditor positionEditor;
	@Autowired
	private DownloadService downloadService;
	@Autowired
	private MasTechnologyService masTechnologyService;
	@Autowired
	private MasJoblevelService masJoblevelService;
	@Autowired
	private MasAddressTypeService masAddressTypeService;
	@Autowired
	private MasProvinceService masProvinceService;
	@Autowired
	private MasRelationTypeService masRelationService;
	@Autowired
	private MasDegreetypeService masDegreeTypeService;
	@Autowired
	private MasSpecialtyService masSpecialtyService;
	@Autowired
	private AbilityService abilityService;
	
	//nut
	@Autowired
	private EmployeeService employeeService;
	
	@Autowired
	private MasDivisionService masDivisionService;
	
	@Autowired
	private LoginService loginService;
	@Autowired
	private ReportService reportService;
	
	@RequestMapping(value = "/applicant", method = { RequestMethod.GET })
	public String helloPage(Model model) {
		User user = (User) SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		String name = user.getUsername();
		model.addAttribute("name", name);
		return "mainApplicant";
	}

	/*-------------------- initBinder --------------------*/
	@InitBinder
	public void InitBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy",
				Locale.ENGLISH);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, true));
//		 binder.registerCustomEditor(Position.class,positionEditor);
		
	}

	/*-------------------- search all applicant --------------------*/
//	 @RequestMapping(value = "/applicant/search", method = { RequestMethod.POST}) 
//	 public @ResponseBody Object searchAllApplicant() { 
//		final List<ApplicantDto> data = applicantService.findAllApplicant(); 
//		return new Object() { public List<ApplicantDto> getData() { return data; } }; 
//	 }

	/*-- search all applicant and applicant by position for dataTable--*/
	@RequestMapping(value = "/applicant/search", method = { RequestMethod.POST })
	public @ResponseBody Object searchByJoblevel(
			@RequestParam final String joblevelStr) throws Exception {
		List<ApplicantDto> data = applicantService.findByJoblevel(joblevelStr);
		if (StringUtils.isEmpty(joblevelStr)) {
			data = applicantService.findAllApplicant();
		}
		final List<ApplicantDto> datas = data;
		return new Object() {
			public List<ApplicantDto> getData() {
				return datas;
			}
		};
	}

	
	/*-------------------- Update Method --------------------*/

//	@RequestMapping(value = "/informations/{id}", method = { RequestMethod.GET })
//	public String informations(@PathVariable Integer id, Model model)
//			throws Exception {
//		User user = (User) SecurityContextHolder.getContext()
//				.getAuthentication().getPrincipal();
//		String name = user.getUsername();
//		model.addAttribute("name", name);
//		System.out.println("APPLICANT_ID : " + id);
//		model.addAttribute("id", id);
//		// applicantService.findById(id);
//		return "informations";
//
//	}

	// Search Applicant By Id
	@RequestMapping(value = "/applicant/search/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDto findById(@PathVariable Integer id)
			throws Exception {
		return applicantService.findApplicantById(id);
	}

	@RequestMapping(value = "/findByIdApplication/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDto findByIdApplication(
			@PathVariable Integer id) throws Exception {

		return applicantService.findApplicationById(id);
	}

	// Edit Applicant Score
	@RequestMapping(value = "/update/score/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDto updateUser(
			@RequestBody ApplicantDto applicantDto, @PathVariable Integer id)
			throws Exception {

		Applicant applicant = applicantService.findById(applicantDto.getId());
		applicant.setScore(applicantDto.getScore());
		applicant.setTechScore(applicantDto.getTechScore());
		applicant.setAttitudeHome(applicantDto.getAttitudeHome());
		applicant.setAttitudeOffice(applicantDto.getAttitudeOffice());
		applicant.setTrackingStatus(applicantDto.getTrackingStatus());
		applicant.setMasLocation("TH");
		
		if (applicant.getTrackingStatus().equals("Approve")) {
			
			//find user
			UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			System.out.println("userName : " + userDetails.getUsername());
			Login login = loginService.findByUserName(userDetails.getUsername());
//			Employee employee = login.getEmployee();
//			System.out.println("employee: " + employee.getNameEng());
			System.out.println("LOCATIONAPPLICANT :: " + applicant.getMasLocation());
			
			EmployeeDto employeeDto = new EmployeeDto();
			Employee employee = new Employee();

			employee.setApplicant(applicant);
			String str = employeeService.generateEmployeeCodeFixData(applicant.getMasLocation());
			System.out.println("SSTRING :: " + str);
			employee.setEmployeeCode(str);
//			employee.setEmployeeCode(employeeService.generateEmployeeCodeFixData(applicantDto.getMasLocation()));
			employee.setStatusemp("Employee");
			MasDivision masDivision = masDivisionService.findById(5);
			employee.setMasDivision(masDivision);
			employee.setTelHome("00-0000000");
			employeeService.create(employee);
			
			System.out.println("SECCESS" + employee.getId());
		}

		applicantService.update(applicant);

		return applicantDto;

	}

	@RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
	public @ResponseBody String delesteUser(@PathVariable("id") Integer id) {

		applicantService.deleteById(id);
		return "success";
		// augRequestService.delete(augRequest);
		// return augRequestService.findById(id);
	}

	/*-------------------- Report Method --------------------*/
	// Main report
	@RequestMapping(value = "/report", method = RequestMethod.GET)
	public String mainReport() {
		return "mainReport";
	}


	/*-------------------- search all applicant and search applicant for Report dataTable--------------------*/
	@RequestMapping(value = "/report/search", method = { RequestMethod.POST })
	public @ResponseBody Object searchReportBy(@RequestParam Integer technology,Integer joblevel,
			Integer masdegreetype, String major, String university, Double gpa)
			throws Exception {

		System.out.println("technology : " + technology);
		System.out.println("joblevel : " + joblevel);
		System.out.println("dagree : " + masdegreetype);
		System.out.println("major : " + major);
		System.out.println("university : " + university);
		System.out.println("gpa : " + gpa);
		
		final List<ReportApplicantDto> data;
		data = applicantService.findReportByCriteria(technology,joblevel, masdegreetype, major,
				university, gpa);

		/*
		 * if (position == -1 && degree.equals("") && major.isEmpty() &&
		 * schoolName.isEmpty() && gpa==null){ data =
		 * applicantService.reportApplicant(); } else { data =
		 * applicantService.findReportByCriteria(position, degree, major,
		 * schoolName, gpa); }
		 */

		return new Object() {
			public List<ReportApplicantDto> getData() {
				return data;
			}
		};
	}

	/*-------------------- preview reports function--------------------*/
	@RequestMapping(value = "/report/preview", method = { RequestMethod.POST,
			RequestMethod.GET })
	public ModelAndView previewReport(
			@ModelAttribute SearchReportDto searchReportDTO,
			HttpSession session, Locale locale) throws Exception {
		List<ReportApplicantDto> reportApplicantList = null;
		Integer technology = searchReportDTO.getTechnology();
		Integer joblevel = searchReportDTO.getJoblevel();
		Integer masdegreetype = searchReportDTO.getMasdegreetype();
		String major = searchReportDTO.getMajor();
		String schoolName = searchReportDTO.getSchoolName();
		Double gpa = searchReportDTO.getGpa();
		
		String reportType = searchReportDTO.getReportType();
		
		
		if (technology == -1 && joblevel == -1 && masdegreetype.equals("") && major.isEmpty() && schoolName.isEmpty() && gpa == null) {
			reportApplicantList = applicantService.reportApplicant();
		} else {
			reportApplicantList = applicantService.findReportByCriteria(technology , joblevel , masdegreetype , major , schoolName , gpa);// search by
		}
		
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("date", new java.util.Date());
		
		if( !StringUtils.isEmpty(schoolName)&& schoolName.length()>0){
			String schoolName1 = " AND education.UNIVERSITY = '"+schoolName+"'";
			parameterMap.put("UNIVERSITY",schoolName1);
		}
		if( !StringUtils.isEmpty(major) && major.length() >0 ){
			String major1 = " AND education.MAJOR = '"+major+"'";
			parameterMap.put("MAJOR",major1);
		}
		if(technology != null){
			String technology1 = " AND technology.ID = "+technology;
			parameterMap.put("TECHNOLOGY", technology1);
		}
		if(joblevel != null ){
			String joblevel1 = " AND joblevel.ID = "+joblevel;
			parameterMap.put("JOBLEVEL", joblevel1);
		}
		if(masdegreetype != null ){
			String masdegreetype1 = " AND degreeType.ID = "+masdegreetype;
			parameterMap.put("DEGREE",masdegreetype1);
		}
		if(gpa != null){
			String gpa1 = " AND education.GPA = "+gpa;
			parameterMap.put("GPA",gpa1);
		}
		parameterMap.put(JRParameter.REPORT_LOCALE, Locale.ENGLISH);
		ModelAndView mv = reportService.getReport(reportApplicantList,
				"reportCriteria", reportType, parameterMap);
		return mv;
	}

	// Monthly report
	@RequestMapping(value = "/monthlyReport", method = RequestMethod.GET)
	public String modalMonthlyReport() {
		return "monthlyReport";
	}

	/*-------------------- search all applicant and search applicant for Report dataTable--------------------*/
	@RequestMapping(value = "/report/searchMonth", method = { RequestMethod.POST })
	public @ResponseBody Object searchReportByMonth(
			@RequestParam String applyDateStr) throws NotFoundException {

		List<ReportApplicantDto> data;

		if (!applyDateStr.isEmpty()) {
			String dateStr = applyDateStr;
			String[] parts = dateStr.split(" \\- ");
			String startDate = parts[0];
			String endDate = parts[1];
			System.out.println("startDate : " + startDate);
			System.out.println("endDate : " + endDate);
			data = applicantService.findReportByMonth(startDate, endDate);
		} else {
			data = applicantService.findReportByCriteria(-1,-1, -1, "", "", null);

		}
		final List<ReportApplicantDto> datas = data;
		return new Object() {
			public List<ReportApplicantDto> getData() {
				return datas;
			}
		};
	}

	@RequestMapping(value = "/reportMonthly/preview", method = { RequestMethod.POST })
	public ModelAndView searchMonthlyReport(
			@ModelAttribute SearchReportDto searchReportDTO,
			HttpSession session, Locale locale) {
		List<ReportApplicantDto> reportApplicantList = null;
		String applyDate = searchReportDTO.getApplyDateStr();

		String reportType = searchReportDTO.getReportType();
		String startDate = "";
		String endDate = "";
		if (!applyDate.isEmpty()) {
			String dateStr = applyDate;
			System.out.println("dateStr :" + dateStr);
			String[] parts = dateStr.split(" \\- ");
			startDate = parts[0];
			System.out.println("startDate : " + startDate);
			endDate = parts[1];
			System.out.println("endDate : " + endDate);
			System.out.println("endDate123 : ");
			reportApplicantList = applicantService.findReportByMonth(startDate,
					endDate);
		} else {
			reportApplicantList = applicantService.reportApplicant();
		}
		
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("date", new java.util.Date());
		parameterMap.put("startDate", startDate);
		parameterMap.put("endDate", endDate);
		parameterMap.put(JRParameter.REPORT_LOCALE, Locale.ENGLISH);
		ModelAndView mv = reportService.getReport(reportApplicantList,
				"summaryMonthly", reportType, parameterMap);
		return mv;
	}
	/*-------------------- Position List--------------------*/
//	@ModelAttribute("positionRequest")
//	public List<Position> getPosition() {
//		return positionService.findAll();
//
//	}

	@ModelAttribute("searchReportDTO")
	public SearchReportDto getsearchReport() {
		return new SearchReportDto();

	}
	
	//================================== Application ===============================
	
	@RequestMapping(value = "/applicationMenu", method = { RequestMethod.GET })
	public String applicationMenu(Model model) {
		LOGGER.info("**** Welcome to Application Controller ****");
		return "applicationMenu";

	}
	
	//////////////////        SAVE METHOD        /////////////////////

	@RequestMapping(value = "/saveInformations", method = { RequestMethod.POST })
	public String saveInformations(@ModelAttribute ApplicantDto applicantDto, Model model,MultipartFile multipartFile)
			throws ParseException {
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		applicantDto.setCode("C"+year+(applicantService.getMaxApplicantId().getId()+1));
		
		if(applicantDto.getImageMultipartFile()!=null&&applicantDto.getImageMultipartFile().getSize()>0){
			try {
				applicantDto.setImage(applicantDto.getImageMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDto.getImageMultipartFile().getOriginalFilename(),applicantDto.getImageMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDto.getResumeMultipartFile()!=null&&applicantDto.getResumeMultipartFile().getSize()>0){
			try {
				applicantDto.setResume(applicantDto.getResumeMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDto.getResumeMultipartFile().getOriginalFilename(),applicantDto.getResumeMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDto.getTranscriptMultipartFile()!=null&&applicantDto.getTranscriptMultipartFile().getSize()>0){
			try {
				applicantDto.setTranscript(applicantDto.getTranscriptMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDto.getTranscriptMultipartFile().getOriginalFilename(),applicantDto.getTranscriptMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
//		if(applicantDTO.getPosition1().getId()<0) applicantDTO.setPosition1(null);
//		if(applicantDTO.getPosition2().getId()<0) applicantDTO.setPosition2(null);
//		if(applicantDTO.getPosition3().getId()<0) applicantDTO.setPosition3(null);
		applicantService.saveInformations(applicantDto);

		model.addAttribute("id", applicantDto.getId());
		model.addAttribute("applicant", applicantDto);
	
		return "informations";
	}

	@RequestMapping(value = "address/address/{id}", method = { RequestMethod.POST })
	public @ResponseBody Address saveAddress(@RequestBody Address address,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		addressService.create(address);
		Address addr = addressService.findById(id);
//		Hibernate.initialize(addr.getApplicant().getTechnology());
//		Hibernate.initialize(addr.getApplicant().getJoblevel());
		
        return addr;
	}
	
	@RequestMapping(value = "family/family/{id}", method = { RequestMethod.POST })
	public @ResponseBody Family saveFamily(@RequestBody Family family,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		familyService.create(family);
		Family fam = familyService.find(id);
		Hibernate.initialize(fam.getApplicant().getTechnology());
		Hibernate.initialize(fam.getApplicant().getJoblevel());
		
        return fam;
	}
	
	@RequestMapping(value = "educations/educations/{id}", method = { RequestMethod.POST })
	public @ResponseBody Education educations(@RequestBody Education education,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		
		educationService.create(education);
		Education ed = educationService.findById(id);
//		Hibernate.initialize(ed.getApplicant().getTechnology());
//		Hibernate.initialize(ed.getApplicant().getJoblevel());
		
        return ed;

	}
	
	@RequestMapping(value = "certificates/certificates/{id}", method = { RequestMethod.POST })
	public @ResponseBody Certification certification(@RequestBody Certification certification,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		certificationService.create(certification);
		Certification cer = certificationService.findById(id);
		Hibernate.initialize(cer.getApplicant().getTechnology());
		Hibernate.initialize(cer.getApplicant().getJoblevel());
        return cer;

	}
	
	@RequestMapping(value = "/skills/skills/{id}", method = { RequestMethod.POST })
	public @ResponseBody Ability skill(@RequestBody Ability ability,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		abilityService.create(ability);
		Ability ab = abilityService.find(id);
		//Hibernate.initialize(ab.getApplicant().getTechnology());
		//Hibernate.initialize(ab.getApplicant().getJoblevel());
        return ab;

	}
	
	@RequestMapping(value = "languages/languages/{id}", method = { RequestMethod.POST })
	public @ResponseBody Language language(@RequestBody Language language,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		languageService.create(language);
		Language lang = languageService.find(id);
//		Hibernate.initialize(lang.getApplicant().getTechnology());
//		Hibernate.initialize(lang.getApplicant().getJoblevel());
//		
        return lang;

	}
	
	@RequestMapping(value = "references/references/{id}", method = { RequestMethod.POST })
	public @ResponseBody Reference references(@RequestBody Reference reference,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		referenceService.create(reference);
		Reference ref = referenceService.findById(id);
//		Hibernate.initialize(ref.getApplicant().getTechnology());
//		Hibernate.initialize(ref.getApplicant().getJoblevel());
        return ref;

	}
	
	@RequestMapping(value = "experiences/experiences/{id}", method = { RequestMethod.POST })
	public @ResponseBody Experience experiences(@RequestBody Experience experience,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		experienceService.create(experience);
		Experience exp = experienceService.findById(id);
		Hibernate.initialize(exp.getApplicant().getTechnology());
		Hibernate.initialize(exp.getApplicant().getJoblevel());
		
        return exp;

	}

	//////////////////        LINK PAGE       ///////////////////////////
	

	@RequestMapping(value = "/informations", method = { RequestMethod.GET })
	public String informations(Model model) {
		LOGGER.info("**** Welcome to Application Controller ****");
		return "informations";

	}
	
	@RequestMapping(value = "/address/{id}", method = { RequestMethod.GET })
	public String address(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "address";
		model.addAttribute("tag",tag);
        return "address";

	}
	
	@RequestMapping(value = "/family/{id}", method = { RequestMethod.GET })
	public String family(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "family";
		model.addAttribute("tag",tag);
        return "family";

	}
	
	@RequestMapping(value = "/educations/{id}", method = { RequestMethod.GET })
	public String educations(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "education";
		model.addAttribute("tag",tag);
        return "educations";

	}
	
	@RequestMapping(value = "/certificates/{id}", method = { RequestMethod.GET })
	public String certificate(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "certificate";
		model.addAttribute("tag",tag);
        return "certificate";

	}
	
	@RequestMapping(value = "/skills/{id}", method = { RequestMethod.GET })
	public String skills(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "skill";
		model.addAttribute("tag",tag);
        return "skills";

	}
	
	@RequestMapping(value = "/languages/{id}", method = { RequestMethod.GET })
	public String languages(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "languages";
		model.addAttribute("tag",tag);
        return "languages";

	}
	
	@RequestMapping(value = "/references/{id}", method = { RequestMethod.GET })
	public String references(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "reference";
		model.addAttribute("tag",tag);
        return "references";

	}
	
	@RequestMapping(value = "/experiences/{id}", method = { RequestMethod.GET })
	public String experiences(@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		String tag = "experience";
		model.addAttribute("tag",tag);
        return "experiences";

	}

    //////////////////        UPDATE METHOD        /////////////////////
	
	// Search Every Class By Id For Show In Text Box
	
	@RequestMapping(value = "/dowloadResume/{id}", method = RequestMethod.GET)
	public String dowloadResume(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) {
 
		String filename = applicantService.findApplicationById(id).getResume();
		downloadService.download(request,response,"Applicant", filename);		
		return "informations";
	}

	@RequestMapping(value = "/dowloadTranscript/{id}", method = RequestMethod.GET)
	public  String dowloadTranscript(@PathVariable Integer id,HttpServletRequest request,HttpServletResponse response) {
 
		String filename = applicantService.findApplicationById(id).getTranscript();
		downloadService.download(request,response,"Applicant", filename);
		return "informations";
	}
	@RequestMapping(value = "/info/{id}", method = { RequestMethod.GET })
	public String updateInfo(@ModelAttribute ApplicantDto applicantDto,
			@PathVariable Integer id, Model  model) {
		applicantDto = applicantService.findByIdApplicant(id);
		String tag = "infomation";
		model.addAttribute("tag","information");
		applicantDto.setTechnology(masTechnologyService.find(applicantDto.getTechnologyId()));
		applicantDto.setJoblevel(masJoblevelService.find(applicantDto.getJoblevelId()));
		model.addAttribute("applicant", applicantDto);
		System.out.println("TECHNOLOGY : "+applicantDto.getTechnology());
		System.out.println("JOBLEVEL : "+applicantDto.getJoblevel());
		System.out.println("Tracking Status : "+applicantDto.getTrackingStatus());
		return "informations";
	}
	
	@RequestMapping(value = "/infoEdit/{id}", method = { RequestMethod.POST })
	public String updateInformations(@ModelAttribute ApplicantDto applicantDto,@PathVariable Integer id,Model  model,MultipartFile multipartFile) {
		if(applicantDto.getImageMultipartFile()!=null&&applicantDto.getImageMultipartFile().getSize()>0){
			try {
				applicantDto.setImage(applicantDto.getImageMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDto.getImageMultipartFile().getOriginalFilename(),applicantDto.getImageMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDto.getResumeMultipartFile()!=null&&applicantDto.getResumeMultipartFile().getSize()>0){
			try {
				applicantDto.setResume(applicantDto.getResumeMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDto.getResumeMultipartFile().getOriginalFilename(),applicantDto.getResumeMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDto.getTranscriptMultipartFile()!=null&&applicantDto.getTranscriptMultipartFile().getSize()>0){
			try {
				applicantDto.setTranscript(applicantDto.getTranscriptMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDto.getTranscriptMultipartFile().getOriginalFilename(),applicantDto.getTranscriptMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
		applicantService.update(applicantDto);
		model.addAttribute("applicant", applicantDto);

		return "informations";
	}
	
	@RequestMapping(value = "/findByIdApplicants/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDto findByIdApplications(@RequestBody ApplicantDto applicantDto,@PathVariable Integer id) {
		applicantDto = applicantService.findApplicationById(id);
		return applicantDto;
	}
	
	@RequestMapping(value = "address/findAddressId/{id}", method = { RequestMethod.POST })
	public @ResponseBody AddressDto findAddress(@PathVariable Integer id) {
		return addressService.findAddress(id);
	}
	
	@RequestMapping(value = "family/findFamilyId/{id}", method = { RequestMethod.POST })
	public @ResponseBody FamilyDto findFamily(@PathVariable Integer id) {
		return familyService.findFamily(id);
	}
	
	@RequestMapping(value = "educations/findEducationId/{id}", method = { RequestMethod.POST })
	public @ResponseBody EducationDto findEducation(@PathVariable Integer id) {
		return educationService.findEducation(id);
	}
	
	@RequestMapping(value = "certificates/findCertificateId/{id}", method = { RequestMethod.POST })
	public @ResponseBody CertificationDto findCertificated(@PathVariable Integer id) {
		return certificationService.findCertificate(id);
	}
	
	@RequestMapping(value = "skills/findSkillId/{id}", method = { RequestMethod.POST })
	public @ResponseBody AbilityDto findSkill(@PathVariable Integer id) {
		return abilityService.findAbility(id);
	}
	
	@RequestMapping(value = "languages/findLanguagesId/{id}", method = { RequestMethod.POST })
	public @ResponseBody LanguageDto findLanguage(@PathVariable Integer id) {
		return languageService.findLanguages(id);
	}
	
	@RequestMapping(value = "references/findReferenceId/{id}", method = { RequestMethod.POST })
	public @ResponseBody ReferenceDto findReference(@PathVariable Integer id) {
		return referenceService.findReference(id);
	}
	
	@RequestMapping(value = "experiences/findExperienceId/{id}", method = { RequestMethod.POST })
	public @ResponseBody ExperienceDto findExperience(@PathVariable Integer id) {
		return experienceService.findExperience(id);
	}
	
	//Get Data For Show In DataTable
	
	@RequestMapping(value = "address/findByIdAddress/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdAddress(@PathVariable Integer id) {
		final List<AddressDto> list= addressService.findAddressById(id);
//		for(AddressDto address : list){
//			System.out.println(address.getAddressType());
//			System.out.println(address.getHouseNo());
//		}
		return new Object() {
			public List<AddressDto> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "family/findByIdFamily/{id}", method = { RequestMethod.POST })
	public @ResponseBody List<FamilyDto> findByIdFamily(@PathVariable Integer id) {
		return familyService.findFamilyById(id);
//		for(FamilyDTO fa : list){
//			System.out.println(fa.getName());
//			System.out.println(fa.getRelation());
//		}
		 
//		return new Object() {
//			public List<FamilyDTO> getData() {
//				return list;
//			}
//		};
	}
	
	@RequestMapping(value = "educations/findByIdEducation/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdEducation(@PathVariable Integer id) {
		 final List<EducationDto> list = educationService.findEducationById(id);
		 
		return new Object() {
			public List<EducationDto> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "certificates/findByIdCertificate/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdCertificaten(@PathVariable Integer id) {
		final List<CertificationDto> list = certificationService.findCertificateById(id);
		for(CertificationDto cer : list){
			System.out.println(cer.getName());
		}
		 
		return new Object() {
			public List<CertificationDto> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "skills/findByIdSkill/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdSkill(@PathVariable Integer id) {
		 final List<AbilityDto> list = abilityService.findAbilityList(id);
		 
		return new Object() {
			public List<AbilityDto> getData() {
				return list;
			}
			
		};
	}
	
	@RequestMapping(value = "languages/findByIdLanguages/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdLanguages(@PathVariable Integer id) {
		 final List<LanguageDto> list = languageService.findLanguagesById(id);
		 
		return new Object() {
			public List<LanguageDto> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "references/findByIdReference/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdReference(@PathVariable Integer id) {
		 final List<ReferenceDto> list = referenceService.findReferenceById(id);
		 
		return new Object() {
			public List<ReferenceDto> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "experiences/findByIdExperience/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdExperience(@PathVariable Integer id) {
		final List<ExperienceDto> list= experienceService.findExperienceById(id);
		 
//			for(ExperienceDto fa : list){
//				System.out.println(fa.getAddress());
//				System.out.println(fa.getDescription());
//				System.out.println(fa.getEmployerName());
//				System.out.println(fa.getPosition());
//				System.out.println(fa.getPositionOfEmployer());
//				System.out.println(fa.getReason());
//				System.out.println(fa.getSalary());
//				System.out.println(fa.getSupervisor());
//				System.out.println(fa.getTypeOfBusiness());
//			}
		 
		return new Object() {
			public List<ExperienceDto> getData() {
				return list;
			}
		};
	}
	
	//Update Data In DataTable
	
	@RequestMapping(value = "address/updateAddress/{id}", method = { RequestMethod.POST })
	public @ResponseBody AddressDto updateAddress(@RequestBody AddressDto addressDto, @PathVariable Integer id) {
		Address address = addressService.findById(addressDto.getId());
		MasAddressType masAddressType = masAddressTypeService.findById(addressDto.getAddressTypeId());
		MasProvince masProvince = masProvinceService.find(addressDto.getMasprovinceId());
		
		address.setId(addressDto.getId());
		address.setAddressType(masAddressType);
		address.setHouseNo(addressDto.getHouseNo());
		address.setRoad(addressDto.getRoad());
		address.setDistrict(addressDto.getDistrict());
		address.setSubDistrict(addressDto.getSubDistrict());
		address.setProvince(masProvince);
		address.setZipcode(addressDto.getZipcode());
		
		addressService.update(address);
		
		return addressDto;
	}
	
	@RequestMapping(value = "family/updateFamily/{id}", method = { RequestMethod.POST })
	public @ResponseBody FamilyDto updateFamily(@RequestBody FamilyDto familyDto, @PathVariable Integer id) {
		Family family = familyService.find(familyDto.getId());
		MasRelationType masRelationType = masRelationService.find(familyDto.getMasRelationTypeId());
		
		family.setId(familyDto.getId());
		family.setAddress(familyDto.getAddress());
		family.setFamilyName(familyDto.getFamilyName());
		family.setOccupation(familyDto.getOccupation());
		family.setPosition(familyDto.getPosition());
		family.setAge(familyDto.getAge());
		family.setGender(familyDto.getGender());
		family.setMobile(familyDto.getMobile());
		family.setMasRelationType(masRelationType);
		
		familyService.update(family);
		
		return familyDto;
	}
	
	@RequestMapping(value = "educations/updateEducations/{id}", method = { RequestMethod.POST })
	public @ResponseBody EducationDto updateEducations(@RequestBody EducationDto educationDto, @PathVariable Integer id) {
		Education education = educationService.findById(educationDto.getId());
		MasDegreetype masDegreeType = masDegreeTypeService.find(educationDto.getMasdegreetypeId());
		
		education.setId(educationDto.getId());
		education.setMasdegreetype(masDegreeType);
		education.setFaculty(educationDto.getFaculty());
		education.setGpa(educationDto.getGpa());
		education.setMajor(educationDto.getMajor());
		education.setUniversity(education.getUniversity());
		education.setStart_date(educationDto.getStart_date());
		education.setGraduated_date(educationDto.getGraduated_date());
		educationService.update(education);
		
		return educationDto;
	}
	
	@RequestMapping(value = "certificates/updateCertificates/{id}", method = { RequestMethod.POST })
	public @ResponseBody CertificationDto updateCertificates(@RequestBody CertificationDto certificationDto, @PathVariable Integer id) {
		Certification certification = certificationService.findById(certificationDto.getId());
		System.out.println(certification+"=======test======");
		certification.setId(certificationDto.getId());
		certification.setCertificationForm(certificationDto.getCertificationForm());
		certification.setName(certificationDto.getName());
		certification.setDescription(certificationDto.getDescription());
		certification.setYear(certificationDto.getYear());
		
		certificationService.update(certification);
		
		return certificationDto;
	}
	
	@RequestMapping(value = "skills/updateSkills/{id}", method = { RequestMethod.POST })
	public @ResponseBody AbilityDto updateSkills(@RequestBody AbilityDto abilityDto, @PathVariable Integer id) {
		Ability skill = abilityService.find(abilityDto.getId());
		MasSpecialty masSpecialty=masSpecialtyService.findById(abilityDto.getMasspecialtyId());
		skill.setId(abilityDto.getId());
		skill.setRank(abilityDto.getRank());
		skill.setMasspecialty(masSpecialty);
		abilityService.update(skill);
		
		return abilityDto;
	}
	
	@RequestMapping(value = "languages/updateLanguages/{id}", method = { RequestMethod.POST })
	public @ResponseBody LanguageDto updateLanguage(@RequestBody LanguageDto languageDto, @PathVariable Integer id) {
		Language languages = languageService.find(languageDto.getId());
		languages.setId(languageDto.getId());
		languages.setNameLanguage(languageDto.getNameLanguage());
		languages.setReading(languageDto.getReading());
		languages.setSpeaking(languageDto.getSpeaking());
		languages.setUnderstanding(languageDto.getUnderstanding());
		languages.setWriting(languageDto.getWriting());
		languageService.update(languages);
		
		return languageDto;
	}
	
	@RequestMapping(value = "references/updateReferences/{id}", method = { RequestMethod.POST })
	public @ResponseBody ReferenceDto updateReferences(@RequestBody ReferenceDto referenceDto, @PathVariable Integer id) {
		Reference reference = referenceService.findById(referenceDto.getId());
		reference.setId(referenceDto.getId());
		reference.setAddress(referenceDto.getAddress());
		reference.setName(referenceDto.getName());
		reference.setOccupation(referenceDto.getOccupation());
		reference.setTel(referenceDto.getTel());
		
		referenceService.update(reference);
		
		return referenceDto;
	}
	
	@RequestMapping(value = "experiences/updateExperience/{id}", method = { RequestMethod.POST })
	public @ResponseBody ExperienceDto updateExperience(@RequestBody ExperienceDto experienceDto, @PathVariable Integer id) throws Exception{
		Experience experience = experienceService.findById(experienceDto.getId());
		experience.setId(experienceDto.getId());
		experience.setAddress(experienceDto.getAddress());
		experience.setReference(experienceDto.getReference());
		experience.setPosition(experienceDto.getPosition());
		experience.setReason(experienceDto.getReason());
		experience.setSalary(experienceDto.getSalary());
		experience.setTypeOfBusiness(experienceDto.getTypeOfBusiness());
		experience.setCompanyName(experienceDto.getCompanyName());
		experience.setDateFrom(experienceDto.getDateFrom());
		experience.setDateTo(experienceDto.getDateTo());
		experience.setResponsibility(experienceDto.getResponsibility());
		
		experienceService.update(experience);
			
		return experienceDto;
	}
	
	////////////////// DELETE METHOD /////////////////////
	
	@RequestMapping(value = "address/deleteAddress/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteAddress(@PathVariable("id") Integer id) {
		addressService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "family/deleteFamily/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteFamily(@PathVariable("id") Integer id) {
		familyService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "educations/deleteEducation/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteEducation(@PathVariable("id") Integer id) {
		educationService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "certificates/deleteCertificate/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteCertificate(@PathVariable("id") Integer id) {
		certificationService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "skills/deleteSkill/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteSkill(@PathVariable("id") Integer id) {
		abilityService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "languages/deleteLanguages/{id}", method = RequestMethod.POST)
	public @ResponseBody String delesteLanguages(@PathVariable("id") Integer id) {
		languageService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "references/deleteReference/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteReference(@PathVariable("id") Integer id) {
		referenceService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "experiences/deleteExperience/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteExperience(@PathVariable("id") Integer id) {
		experienceService.deleteById(id);
		return "success";
	}
//	------------------------------------------------
//	@ModelAttribute("departments")
//	@Transactional
//	public List<Department> departmentList() {
//		System.out.println(departmentService.findAll());
//		return departmentService.findAll();
//	}
//
//	@ModelAttribute("positions")
//	@Transactional
//	public List<Position> positionList() {
//		//System.out.println(positionService.findAll());
//		return positionService.findAll();
//	}
	@ModelAttribute("applicant")
	public ApplicantDto applicant() {
		return new ApplicantDto();
	}
	
	@ModelAttribute("jobLevels")
	@Transactional
	public List<MasJoblevel> jobLevelList(){
		return masJoblevelService.findAll();
	}
	
	@ModelAttribute("technologies")
	@Transactional
	public List<MasTechnology> technologyList(){
		return masTechnologyService.findAll();
	}
	
	@ModelAttribute("addresses")
	@Transactional
	public List<MasAddressType> addressList(){
		return masAddressTypeService.findAll();
	}
	
	@ModelAttribute("provinces")
	@Transactional
	public List<MasProvince> provinceList(){
		return masProvinceService.findAll();
	}
	
	@ModelAttribute("relations")
	@Transactional
	public List<MasRelationType> relationList(){
		return masRelationService.findAll();
	}
	
	@ModelAttribute("degreeTypes")
	@Transactional
	public List<MasDegreetype> degreeTypesList(){
/*		Model model = null;
		EducationDto educationDto = new EducationDto();
		Integer ed = educationDto.getMasdegreetypeId();
		model.addAttribute("masdegreetypeId", ed);*/
		return masDegreeTypeService.findAll();
	}
	
	@ModelAttribute("masspecialties")
	@Transactional
	public List<MasSpecialty> masspecialtyList(){
		return masSpecialtyService.findAll();
	}	
}
