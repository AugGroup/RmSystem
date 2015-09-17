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

import net.sf.jasperreports.engine.JRParameter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
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

import com.aug.hrdb.dto.ApplicantDto;
import com.aug.hrdb.services.AddressService;
import com.aug.hrdb.services.ApplicantService;
import com.aug.hrdb.services.CertificationService;
import com.aug.hrdb.services.EducationService;
import com.aug.hrdb.services.ExperienceService;
import com.aug.hrdb.services.FamilyService;
import com.aug.hrdb.services.LanguageService;
import com.aug.hrdb.services.MasCoreSkillService;
import com.aug.hrdb.services.MasJoblevelService;
import com.aug.hrdb.services.MasTechnologyService;
import com.aug.hrdb.services.ReferenceService;
import com.aug.services.DownloadService;
import com.aug.services.ReportService;
import com.aug.services.UploadService;

@Controller
// @SessionAttributes("applicant")
public class ApplicantController implements Serializable {

	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = LoggerFactory.getLogger(ApplicantController.class);

	@Autowired
	private ApplicantService applicantService;
//	@Autowired
//	private PositionService positionService;
	@Autowired
	private ReportService reportService;
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
//	@Autowired
//	private SkillService skillService;
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
	private MasCoreSkillService masCoreSkillService;
	
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
		 binder.registerCustomEditor(Position.class,positionEditor);
		
	}

	/*-------------------- search all applicant --------------------*/
	/*
	 * @RequestMapping(value = "/applicant/search", method = { RequestMethod.GET
	 * }) public @ResponseBody Object searchAllApplicant() { final
	 * List<ApplicantDTO> data = applicantService.findAllApplicant(); return new
	 * Object() { public List<ApplicantDTO> getData() { return data; } }; }
	 */

	/*-- search all applicant and applicant by position for dataTable--*/
	@RequestMapping(value = "/applicant/searchTechnology", method = { RequestMethod.POST })
	public @ResponseBody Object searchByTechnology(
			@RequestParam final String technology) throws Exception {
		List<ApplicantDto> data = applicantService.findByTechnology(technology);
		if (StringUtils.isEmpty(technology)) {
			data = applicantService.findAllApplicant();
		}
		final List<ApplicantDTO> datas = data;
		return new Object() {
			public List<ApplicantDTO> getData() {
				return datas;
			}
		};
	}
	@RequestMapping(value = "/applicant/searchJoblevel", method = { RequestMethod.POST })
	public @ResponseBody Object searchByJoblevel(
			@RequestParam final String joblevel) throws Exception {
		List<ApplicantDTO> data = applicantService.findByTechnology(joblevel);
		if (StringUtils.isEmpty(joblevel)) {
			data = applicantService.findAllApplicant();
		}
		final List<ApplicantDTO> datas = data;
		return new Object() {
			public List<ApplicantDTO> getData() {
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
	public @ResponseBody ApplicantDTO findById(@PathVariable Integer id)
			throws Exception {
		return applicantService.findApplicantById(id);
	}

	@RequestMapping(value = "/findByIdApplication/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDTO findByIdApplication(
			@PathVariable Integer id) throws Exception {

		return applicantService.findApplicationById(id);
	}

	// Edit Applicant Score
	@RequestMapping(value = "/update/score/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDTO updateUser(
			@RequestBody ApplicantDTO applicantDTO, @PathVariable Integer id)
			throws Exception {

		Applicant applicant = applicantService.findById(applicantDTO.getId());
		applicant.setScore(applicantDTO.getScore());
		applicant.setTechScore(applicantDTO.getTechScore());
		applicant.setAttitudeHome(applicantDTO.getAttitudeHome());
		applicant.setAttitudeOffice(applicantDTO.getAttitudeOffice());
		applicant.setTrackingStatus(applicantDTO.getTrackingStatus());

		applicantService.update(applicant);

		return applicantDTO;

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
			String degree, String major, String schoolName, Double gpa)
			throws Exception {

		final List<ReportApplicantDTO> data;
		data = applicantService.findReportByCriteria(technology,joblevel, degree, major,
				schoolName, gpa);

		/*
		 * if (position == -1 && degree.equals("") && major.isEmpty() &&
		 * schoolName.isEmpty() && gpa==null){ data =
		 * applicantService.reportApplicant(); } else { data =
		 * applicantService.findReportByCriteria(position, degree, major,
		 * schoolName, gpa); }
		 */

		return new Object() {
			public List<ReportApplicantDTO> getData() {
				return data;
			}
		};
	}

	/*-------------------- preview reports function--------------------*/
	@RequestMapping(value = "/report/preview", method = { RequestMethod.POST,
			RequestMethod.GET })
	public ModelAndView previewReport(
			@ModelAttribute SearchReportDTO searchReportDTO,
			HttpSession session, Locale locale) throws Exception {
		List<ReportApplicantDTO> reportApplicantList = null;
		Integer technology = searchReportDTO.getTechnology();
		Integer joblevel = searchReportDTO.getJoblevel();
		String degree = searchReportDTO.getDegree();
		String major = searchReportDTO.getMajor();
		String schoolName = searchReportDTO.getSchoolName();
		Double gpa = searchReportDTO.getGpa();
		
		String reportType = searchReportDTO.getReportType();
		
		if (technology == -1 && joblevel == -1 && degree.equals("") && major.isEmpty() && schoolName.isEmpty() && gpa == null) {
			reportApplicantList = applicantService.reportApplicant();
		} else {
			reportApplicantList = applicantService.findReportByCriteria(technology , joblevel , degree , major , schoolName , gpa);// search by
		}

		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("date", new java.util.Date());
		parameterMap.put(JRParameter.REPORT_LOCALE, Locale.ENGLISH);
		ModelAndView mv = reportService.getReport(reportApplicantList,
				"Report_AugRmSystem", reportType, parameterMap);
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

		List<ReportApplicantDTO> data;

		if (!applyDateStr.isEmpty()) {
			String dateStr = applyDateStr;
			String[] parts = dateStr.split(" \\- ");
			String startDate = parts[0];
			String endDate = parts[1];
			System.out.println("startDate : " + startDate);
			System.out.println("endDate : " + endDate);
			data = applicantService.findReportByMonth(startDate, endDate);
		} else {
			data = applicantService.findReportByCriteria(-1,-1, "", "", "", null);

		}
		final List<ReportApplicantDTO> datas = data;
		return new Object() {
			public List<ReportApplicantDTO> getData() {
				return datas;
			}
		};
	}

	@RequestMapping(value = "/reportMonthly/preview", method = { RequestMethod.POST })
	public ModelAndView searchMonthlyReport(
			@ModelAttribute SearchReportDTO searchReportDTO,
			HttpSession session, Locale locale) {
		List<ReportApplicantDTO> reportApplicantList = null;
		String applyDate = searchReportDTO.getApplyDateStr();

		String reportType = searchReportDTO.getReportType();
		if (!applyDate.isEmpty()) {
			String dateStr = applyDate;
			System.out.println("dateStr :" + dateStr);
			String[] parts = dateStr.split(" \\- ");
			String startDate = parts[0];
			System.out.println("startDate : " + startDate);
			String endDate = parts[1];
			System.out.println("endDate : " + endDate);
			System.out.println("endDate123 : ");
			reportApplicantList = applicantService.findReportByMonth(startDate,
					endDate);
		} else {
			reportApplicantList = applicantService.reportApplicant();
		}
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("date", new java.util.Date());
		parameterMap.put(JRParameter.REPORT_LOCALE, Locale.ENGLISH);
		ModelAndView mv = reportService.getReport(reportApplicantList,
				"applicantSummaryMonthly", reportType, parameterMap);
		return mv;
	}

	/*-------------------- Position List--------------------*/
	@ModelAttribute("positionRequest")
	public List<Position> getPosition() {
		return positionService.findAll();

	}

	@ModelAttribute("searchReportDTO")
	public SearchReportDTO getsearchReport() {
		return new SearchReportDTO();

	}
	
	//================================== Application ===============================
	
	@RequestMapping(value = "/applicationMenu", method = { RequestMethod.GET })
	public String applicationMenu(Model model) {
		LOGGER.info("**** Welcome to Application Controller ****");
		return "applicationMenu";

	}
	
	//////////////////        SAVE METHOD        /////////////////////

	@RequestMapping(value = "/saveInformations", method = { RequestMethod.POST })
	public String saveInformations(@ModelAttribute ApplicantDTO applicantDTO, Model model,MultipartFile multipartFile)
			throws ParseException {
		
		int year = Calendar.getInstance().get(Calendar.YEAR);
		
		applicantDTO.setCode("C"+year+(applicantService.getMaxApplicantId().getId()+1));
		
		if(applicantDTO.getImageMultipartFile()!=null&&applicantDTO.getImageMultipartFile().getSize()>0){
			try {
				applicantDTO.setImage(applicantDTO.getImageMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDTO.getImageMultipartFile().getOriginalFilename(),applicantDTO.getImageMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDTO.getResumeMultipartFile()!=null&&applicantDTO.getResumeMultipartFile().getSize()>0){
			try {
				applicantDTO.setResume(applicantDTO.getResumeMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDTO.getResumeMultipartFile().getOriginalFilename(),applicantDTO.getResumeMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDTO.getTranscriptMultipartFile()!=null&&applicantDTO.getTranscriptMultipartFile().getSize()>0){
			try {
				applicantDTO.setTranscript(applicantDTO.getTranscriptMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDTO.getTranscriptMultipartFile().getOriginalFilename(),applicantDTO.getTranscriptMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
//		
//		if(applicantDTO.getPosition1().getId()<0) applicantDTO.setPosition1(null);
//		if(applicantDTO.getPosition2().getId()<0) applicantDTO.setPosition2(null);
//		if(applicantDTO.getPosition3().getId()<0) applicantDTO.setPosition3(null);
//		applicantService.saveInformations(applicantDTO);

		model.addAttribute("id", applicantDTO.getId());
		model.addAttribute("applicant", applicantDTO);
	/*	System.out.println("POSITION 1 : "+applicationDTO.getPosition1().getId());
		System.out.println("POSITION 2 : "+applicationDTO.getPosition2().getId());
		System.out.println("POSITION 3 : "+applicationDTO.getPosition3().getId());
*/
		return "informations";
	}

	@RequestMapping(value = "address/address/{id}", method = { RequestMethod.POST })
	public @ResponseBody Address saveAddress(@RequestBody Address address,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		addressService.create(address);
		Address addr = addressService.findById(id);
		
        return addr;
	}
	
	@RequestMapping(value = "family/family/{id}", method = { RequestMethod.POST })
	public @ResponseBody Family saveFamily(@RequestBody Family family,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		familyService.create(family);
		Family fam = familyService.findById(id);
		
        return fam;
	}
	
	@RequestMapping(value = "/educations/{id}", method = { RequestMethod.POST })
	public @ResponseBody Education educations(@RequestBody Education education,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		educationService.create(education);
		Education ed = educationService.findById(id);
        return ed;

	}
	
	@RequestMapping(value = "certificates/certificates/{id}", method = { RequestMethod.POST })
	public @ResponseBody Certificate certificate(@RequestBody Certificate certificate,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		certificatedService.create(certificate);
		Certificate cer = certificatedService.findById(id);
        return cer;

	}
	
	@RequestMapping(value = "/skills/{id}", method = { RequestMethod.POST })
	public @ResponseBody Skill skills(@RequestBody Skill skill,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		skillService.create(skill);
		Skill skills = skillService.findById(id);
        return skills;

	}
	
	@RequestMapping(value = "/languages/{id}", method = { RequestMethod.POST })
	public @ResponseBody Languages languages(@RequestBody Languages languages,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		languagesService.create(languages);
		Languages lang = languagesService.findById(id);
        return lang;

	}
	
	@RequestMapping(value = "/references/{id}", method = { RequestMethod.POST })
	public @ResponseBody Reference references(@RequestBody Reference reference,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		referenceService.create(reference);
		Reference ref = referenceService.findById(id);
        return ref;

	}
	
	@RequestMapping(value = "/experiences/{id}", method = { RequestMethod.POST })
	public @ResponseBody Experience experiences(@RequestBody Experience experience,@PathVariable Integer id,Model model) {
		model.addAttribute("id",id);
		experienceService.create(experience);
		Experience exper = experienceService.findById(id);
        return exper;

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
	public String updateInfo(@ModelAttribute ApplicantDTO applicantDTO,
			@PathVariable Integer id, Model  model) {
		applicantDTO = applicantService.findByIdApplicant(id);
		String tag = "infomation";
		model.addAttribute("tag","information");
		applicantDTO.setTechnology(masTechnologyService.findById(applicantDTO.getTechnologyId()));
		applicantDTO.setJoblevel(masJobLevelService.findById(applicantDTO.getJoblevelId()));
		model.addAttribute("applicant", applicantDTO);
		System.out.println("TECHNOLOGY : "+applicantDTO.getTechnology());
		System.out.println("JOBLEVEL : "+applicantDTO.getJoblevel());
		System.out.println("Tracking Status : "+applicantDTO.getTrackingStatus());
		return "informations";
	}
	
	@RequestMapping(value = "/infoEdit/{id}", method = { RequestMethod.POST })
	public String updateInformations(@ModelAttribute ApplicantDTO applicantDTO,@PathVariable Integer id,Model  model,MultipartFile multipartFile) {
		if(applicantDTO.getImageMultipartFile()!=null&&applicantDTO.getImageMultipartFile().getSize()>0){
			try {
				applicantDTO.setImage(applicantDTO.getImageMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDTO.getImageMultipartFile().getOriginalFilename(),applicantDTO.getImageMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDTO.getResumeMultipartFile()!=null&&applicantDTO.getResumeMultipartFile().getSize()>0){
			try {
				applicantDTO.setResume(applicantDTO.getResumeMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDTO.getResumeMultipartFile().getOriginalFilename(),applicantDTO.getResumeMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		if(applicantDTO.getTranscriptMultipartFile()!=null&&applicantDTO.getTranscriptMultipartFile().getSize()>0){
			try {
				applicantDTO.setTranscript(applicantDTO.getTranscriptMultipartFile().getOriginalFilename());
				uploadService.upload("Applicant",applicantDTO.getTranscriptMultipartFile().getOriginalFilename(),applicantDTO.getTranscriptMultipartFile());
			} catch (RuntimeException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	
		applicantService.update(applicantDTO);
		model.addAttribute("applicant", applicantDTO);

		return "informations";
	}
	
	@RequestMapping(value = "/findByIdApplicants/{id}", method = { RequestMethod.POST })
	public @ResponseBody ApplicantDTO findByIdApplications(@RequestBody ApplicantDTO applicantDTO,@PathVariable Integer id) {
		applicantDTO = applicantService.findApplicationById(id);
		return applicantDTO;
	}
	
	@RequestMapping(value = "address/findAddressId/{id}", method = { RequestMethod.POST })
	public @ResponseBody AddressDTO findAddress(@PathVariable Integer id) {
		return addressService.findAddress(id);
	}
	
	@RequestMapping(value = "family/findFamilyId/{id}", method = { RequestMethod.POST })
	public @ResponseBody FamilyDTO findFamily(@PathVariable Integer id) {
		return familyService.findFamily(id);
	}
	
	@RequestMapping(value = "educations/findEducationId/{id}", method = { RequestMethod.POST })
	public @ResponseBody EducationDTO findEducation(@PathVariable Integer id) {
		return educationService.findEducation(id);
	}
	
	@RequestMapping(value = "certificates/findCertificateId/{id}", method = { RequestMethod.POST })
	public @ResponseBody CertificatedDTO findCertificated(@PathVariable Integer id) {
		return certificatedService.findCertificate(id);
	}
	
	@RequestMapping(value = "skills/findSkillId/{id}", method = { RequestMethod.POST })
	public @ResponseBody SkillDTO findSkill(@PathVariable Integer id) {
		return skillService.findSkill(id);
	}
	
	@RequestMapping(value = "languages/findLanguagesId/{id}", method = { RequestMethod.POST })
	public @ResponseBody LanguagesDTO findLanguages(@PathVariable Integer id) {
		return languagesService.findLanguages(id);
	}
	
	@RequestMapping(value = "references/findReferenceId/{id}", method = { RequestMethod.POST })
	public @ResponseBody ReferenceDTO findReference(@PathVariable Integer id) {
		return referenceService.findReference(id);
	}
	
	@RequestMapping(value = "experiences/findExperienceId/{id}", method = { RequestMethod.POST })
	public @ResponseBody ExperienceDTO findExperience(@PathVariable Integer id) {
		return experienceService.findExperience(id);
	}
	
	//Get Data For Show In DataTable
	
	@RequestMapping(value = "address/findByIdAddress/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdAddress(@PathVariable Integer id) {
		final List<AddressDTO> list= addressService.findAddressById(id);
		for(AddressDTO address : list){
			System.out.println(address.getAddressType());
			System.out.println(address.getHouseNo());
		}
		return new Object() {
			public List<AddressDTO> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "family/findByIdFamily/{id}", method = { RequestMethod.POST })
	public @ResponseBody List<FamilyDTO> findByIdFamily(@PathVariable Integer id) {
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
		 final List<EducationDTO> list = educationService.findEducationById(id);
		 
		return new Object() {
			public List<EducationDTO> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "certificates/findByIdCertificate/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdCertificaten(@PathVariable Integer id) {
		final List<CertificatedDTO> list = certificatedService.findCertificateById(id);
		for(CertificatedDTO cer : list){
			System.out.println(cer.getCertificateName());
		}
		 
		return new Object() {
			public List<CertificatedDTO> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "skills/findByIdSkill/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdSkill(@PathVariable Integer id) {
		 final List<SkillDTO> list = skillService.findSkillById(id);
		 
		return new Object() {
			public List<SkillDTO> getData() {
				return list;
			}
			
		};
	}
	
	@RequestMapping(value = "languages/findByIdLanguages/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdLanguages(@PathVariable Integer id) {
		 final List<LanguagesDTO> list = languagesService.findLanguagesById(id);
		 
		return new Object() {
			public List<LanguagesDTO> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "references/findByIdReference/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdReference(@PathVariable Integer id) {
		 final List<ReferenceDTO> list = referenceService.findReferenceById(id);
		 
		return new Object() {
			public List<ReferenceDTO> getData() {
				return list;
			}
		};
	}
	
	@RequestMapping(value = "experiences/findByIdExperience/{id}", method = { RequestMethod.POST })
	public @ResponseBody Object findByIdExperience(@PathVariable Integer id) {
		final List<ExperienceDTO> list= experienceService.findExperienceById(id);
		 
			for(ExperienceDTO fa : list){
				System.out.println(fa.getAddress());
				System.out.println(fa.getDescription());
				System.out.println(fa.getEmployerName());
				System.out.println(fa.getPosition());
				System.out.println(fa.getPositionOfEmployer());
				System.out.println(fa.getReason());
				System.out.println(fa.getSalary());
				System.out.println(fa.getSupervisor());
				System.out.println(fa.getTypeOfBusiness());
			}
		 
		return new Object() {
			public List<ExperienceDTO> getData() {
				return list;
			}
		};
	}
	
	//Update Data In DataTable
	
	@RequestMapping(value = "address/updateAddress/{id}", method = { RequestMethod.POST })
	public @ResponseBody AddressDTO updateAddress(@RequestBody AddressDTO addressDTO, @PathVariable Integer id) {
		Address address = addressService.findById(addressDTO.getId());
		address.setAddressType(addressDTO.getAddressType());
		address.setHouseNo(addressDTO.getHouseNo());
		address.setRoad(addressDTO.getRoad());
		address.setDistrict(addressDTO.getDistrict());
		address.setSubDistrict(addressDTO.getSubDistrict());
		address.setProvince(addressDTO.getProvince());
		address.setZipcode(addressDTO.getZipcode());
		
		addressService.update(address);
		
		return addressDTO;
	}
	
	@RequestMapping(value = "family/updateFamily/{id}", method = { RequestMethod.POST })
	public @ResponseBody FamilyDTO updateFamily(@RequestBody FamilyDTO familyDTO, @PathVariable Integer id) {
		Family family = familyService.findById(familyDTO.getId());
		family.setId(familyDTO.getId());
		family.setAddress(familyDTO.getAddress());
		family.setName(familyDTO.getName());
		family.setOccupation(familyDTO.getOccupation());
		family.setPositionFamily(familyDTO.getPositionFamily());
		family.setRelation(familyDTO.getRelation());
		
		familyService.update(family);
		
		return familyDTO;
	}
	
	@RequestMapping(value = "educations/updateEducations/{id}", method = { RequestMethod.POST })
	public @ResponseBody EducationDTO updateEducations(@RequestBody EducationDTO educationDTO, @PathVariable Integer id) {
		Education education = educationService.findById(educationDTO.getId());
		education.setId(educationDTO.getId());
		education.setDegree(educationDTO.getDegree());
		education.setFaculty(educationDTO.getFaculty());
		education.setGpa(educationDTO.getGpa());
		education.setMajor(educationDTO.getMajor());
		education.setSchoolName(educationDTO.getSchoolName());
		education.setYearsOfGraduate(educationDTO.getYearsOfGraduate());
		
		educationService.update(education);
		
		return educationDTO;
	}
	
	@RequestMapping(value = "certificates/updateCertificates/{id}", method = { RequestMethod.POST })
	public @ResponseBody CertificatedDTO updateCertificates(@RequestBody CertificatedDTO certificateDTO, @PathVariable Integer id) {
		Certificate certificate = certificatedService.findById(certificateDTO.getId());
		certificate.setId(certificateDTO.getId());
		certificate.setCertificateName(certificateDTO.getCertificateName());
		
		certificatedService.update(certificate);
		
		return certificateDTO;
	}
	
	@RequestMapping(value = "skills/updateSkills/{id}", method = { RequestMethod.POST })
	public @ResponseBody SkillDTO updateSkills(@RequestBody SkillDTO skillDTO, @PathVariable Integer id) {
		Skill skill = skillService.findById(skillDTO.getId());
		skill.setId(skillDTO.getId());
		skill.setSkillDetail(skillDTO.getSkillDetail());
		
		skillService.update(skill);
		
		return skillDTO;
	}
	
	@RequestMapping(value = "languages/updateLanguages/{id}", method = { RequestMethod.POST })
	public @ResponseBody LanguagesDTO updateLanguages(@RequestBody LanguagesDTO languagesDTO, @PathVariable Integer id) {
		Languages languages = languagesService.findById(languagesDTO.getId());
		languages.setId(languagesDTO.getId());
		languages.setLanguagesName(languagesDTO.getLanguagesName());
		languages.setReading(languagesDTO.getReading());
		languages.setSpeaking(languagesDTO.getSpeaking());
		languages.setUnderstanding(languagesDTO.getUnderstanding());
		languages.setWriting(languagesDTO.getWriting());
		
		languagesService.update(languages);
		
		return languagesDTO;
	}
	
	@RequestMapping(value = "references/updateReferences/{id}", method = { RequestMethod.POST })
	public @ResponseBody ReferenceDTO updateReferences(@RequestBody ReferenceDTO referenceDTO, @PathVariable Integer id) {
		Reference reference = referenceService.findById(referenceDTO.getId());
		reference.setId(referenceDTO.getId());
		reference.setCompleteAddress(referenceDTO.getCompleteAddress());
		reference.setFullName(referenceDTO.getFullName());
		reference.setOccupation(referenceDTO.getOccupation());
		reference.setTel(referenceDTO.getTel());
		
		referenceService.update(reference);
		
		return referenceDTO;
	}
	
	@RequestMapping(value = "experiences/updateExperience/{id}", method = { RequestMethod.POST })
	public @ResponseBody ExperienceDTO updateExperience(@RequestBody ExperienceDTO experienceDTO, @PathVariable Integer id) throws Exception{
		Experience experience = experienceService.findById(experienceDTO.getId());
		experience.setId(experienceDTO.getId());
		experience.setAddress(experienceDTO.getAddress());
		experience.setDescription(experienceDTO.getDescription());
		experience.setEmployerName(experienceDTO.getEmployerName());
//		experience.setFromDate(experienceDTO.getFromDate());
//		experience.setToDate(experienceDTO.getToDate());
		experience.setPosition(experienceDTO.getPosition());
		experience.setPositionOfEmployer(experienceDTO.getPositionOfEmployer());
		experience.setReason(experienceDTO.getReason());
		experience.setSalary(experienceDTO.getSalary());
		experience.setSupervisor(experienceDTO.getSupervisor());
		experience.setTypeOfBusiness(experienceDTO.getTypeOfBusiness());
		experience.setApplyDateStr(experienceDTO.getApplyDateStr());
		
		experienceService.update(experience);
			
		return experienceDTO;
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
		certificatedService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "skills/deleteSkill/{id}", method = RequestMethod.POST)
	public @ResponseBody String deleteSkill(@PathVariable("id") Integer id) {
		skillService.deleteById(id);
		return "success";
	}
	
	@RequestMapping(value = "languages/deleteLanguages/{id}", method = RequestMethod.POST)
	public @ResponseBody String delesteLanguages(@PathVariable("id") Integer id) {
		languagesService.deleteById(id);
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
	public ApplicantDTO applicant() {
		return new ApplicantDTO();
	}
}
