<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
	var firstNameTH = "<spring:message code="valid.info.first.th"/>";
	var	lastNameTH = "<spring:message code="valid.info.last.th"/>";
	var	nickNameTH = "<spring:message code="valid.info.nick.th"/>";
	var	firstNameEN = "<spring:message code="valid.info.first.en"/>";
	var	lastNameEN = "<spring:message code="valid.info.last.en"/>";
	var	nickNameEN = "<spring:message code="valid.info.nick.en"/>";
	var	tel = "<spring:message code="valid.ref.tel"/>";
	var	email = "<spring:message code="valid.info.email"/>";
	var	emailFormat = "<spring:message code="valid.info.email.format"/>";
	var	birthDate = "<spring:message code="valid.info.birthday"/>";
	var	placeBirth = "<spring:message code="valid.info.place.birth"/>";
	var	age = "<spring:message code="valid.info.age"/>";
	var	religion = "<spring:message code="valid.info.religion"/>";
	var	nationality = "<spring:message code="valid.info.nationality"/>";
	var	cardId = "<spring:message code="valid.info.id.card"/>";
	var	cardIssuedOffice = "<spring:message code="valid.fam.issued"/>";
	var cardExpiryDate = "<spring:message code="valid.info.expiry"/>";
	var	height = "<spring:message code="valid.info.height"/>";
	var	weight = "<spring:message code="valid.info.weight"/>";
	var	sex = "<spring:message code="valid.info.sex"/>";
	var	applicantStatus = "<spring:message code="valid.info.status"/>";
	var numberOfChildren = "<spring:message code="valid.info.child"/>";
	var spouseName = "<spring:message code="valid.fam.spouse"/>";
	var marriageCertificateNo = "<spring:message code="valid.fam.marrige"/>";
	var issueOficeMarriage = "<spring:message code="valid.info.issued.milital"/>";
	var marriageAddress = "<spring:message code="valid.addr.addr"/>";
	var occupationMarriage = "<spring:message code="valid.fam.occ"/>";
	var militaryStatus = "<spring:message code="valid.info.status"/>";
	var militaryFromYear = "<spring:message code="valid.info.from"/>";
	var militarytoYear = "<spring:message code="valid.info.to"/>";
	var branchService = "<spring:message code="valid.info.branch"/>";
	var militaryPlace = "<spring:message code="valid.info.military.place"/>";
	var militaryServiceNo = "<spring:message code="valid.info.military.ser"/>";
	var militaryReason = "<spring:message code="valid.info.reason"/>";
	var dateToBeDrafted = "<spring:message code="valid.info.drafted"/>";
	var emergencyName = "<spring:message code="valid.info.emer.name"/>";
	var emergencyTel = "<spring:message code="valid.info.emer.tel"/>";
	var emergencyAddress = "<spring:message code="valid.info.emer.addr"/>";
	var applyDate = "<spring:message code="valid.info.apply.date"/>";
	var department = "<spring:message code="valid.info.dep"/>";
	var jobLevel = "<spring:message code="valid.info.pos1"/>";
	var technology = "<spring:message code="valid.info.ask"/>";
	var	expectedSalary = "<spring:message code="valid.info.salary"/>";
	var	nowEmployed = "<spring:message code="valid.info.ask"/>";
	var	employedName = "<spring:message code="valid.ref.name"/>";
	var	employedPosition = "<spring:message code="valid.ex.position"/>";
	var employedRelation = "<spring:message code="valid.info.relation"/>";
	var	previousEmployers = "<spring:message code="valid.info.pre.emp"/>";
	var	previousEmployersReason = "<spring:message code="valid.ex.reason"/>";
	var minDigitTwo = "<spring:message code="valid.minDigit.two"/>";
	var maxDigitThree = "<spring:message code="valid.maxDigit.three"/>";
	var digitOnly = "<spring:message code="valid.digit.only"/>";
	var lettersOnly = "<spring:message code="valid.letters.only"/>";
	var thaiOnly = "<spring:message code="valid.thai.only"/>";
	var joblevelVal = "<spring:message code="valid.req.joblevel"/>";
	var technologyVal = "<spring:message code="valid.req.technology"/>";
	var resumeMultipartFile = "<spring:message code="valid.req.resume"/>";
	var imageMultipartFile =  "<spring:message code="valid.req.image"/>";
</script>