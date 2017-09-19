//
//  HAConstURL.m
//  CORE
//
//  CREATED BY LUO YU ON 2017-02-28.
//  COPYRIGHT (C) 2017 LUO YU. ALL RIGHTS RESERVED.
//

#import "HAConstURL.h"

NSString *const URL_AUTH_LOGIN = @"/user/login.do";
NSString *const URL_AUTH_REGISTER = @"/user/register.do";
NSString *const URL_AUTH_VERIFICATION_CODE = @"/sms/get.do";
NSString *const URL_AUTH_ADDRESSES = @"/area/findByParent.do";
NSString *const URL_AUTH_AREA_FINDID = @"/area/findById.do";
NSString *const URL_AUTH_DEPT_INFO = @"/dept/findById.do";
NSString *const	URL_AUTH_DEPT_LIST = @"/dept/findByParent.do";
NSString *const URL_AUTH_DEPT_TYPE = @"/dept/listTypes.do";
NSString *const URL_AUTH_DEPT_LIST_AREA = @"/dept/findByArea.do";
NSString *const URL_AUTH_USERTYPR = @"/jobs/findByDept.do";
NSString *const URL_AUTH_HAS_PHONE = @"/user/hasphone.do";
NSString *const URL_AUTH_FORGOT_RESET = @"/user/findPwd.do";
NSString *const URL_AUTH_USER_UPDATE = @"/user/updateUserInfo.do";
NSString *const URL_AUTH_GET_UID = @"/token/findUidByToken.do";
NSString *const URL_AUTH_USER_INFO = @"/token/findUserByToken.do";
NSString *const URL_AUTH_USER_PAXY_INFO = @"/token/findUserByToken.do";
NSString *const URL_AUTH_UPDATE_PWD = @"/user/updatePwd.do";
NSString *const URL_AUTH_USER_YGWJW_UPDATE = @"/user/info.action";

NSString *const URL_POLICE_ALERT_CREATE = @"/alert/createAlert.do";

NSString *const URL_AUTH_REGISTER_CODE_VERIFY = @"/auth/register_vcode_invaild.action";
NSString *const URL_AUTH_USER_TYPE = @"/getUserTypeListByZone.action";
NSString *const URL_AUTH_ID_VERIFICATION = @"/user/submit_verification.action";
NSString *const URL_AUTH_FORGOT_VCODE = @"/auth/findpwd_vcode.action";
NSString *const URL_POLICE_ALERT_UPDATE = @"/alert/user_trigger.action";
NSString *const URL_POLICE_APPOINTED = @"/Appointed/saveAuditRecord.action";
NSString *const URL_POLICE_APPENDALERT = @"/alert/appendalert_process.action";
NSString *const URL_POLICE_GETREPORTLIST = @"/alert/getReportList.action";
NSString *const URL_POLICE_PROCESS = @"/alert/alert_process.action";
NSString *const URL_POLICE_COMMENTS = @"/comments/saveCommentsInfo.action";
NSString *const	URL_POLICE_FINDCOMMENTS = @"/comments/findCommentsInfoToAlertid.action";
NSString *const URL_POLICE_ALERT_LIST = @"/alert/alert_list.action";

NSString *const URL_SERVICE_NEWS = @"/content/news.action";

NSString *const URL_MORE_SEND_MSG = @"/msg/send.action";
NSString *const URL_MORE_LIST_MSG = @"/msg/list.action";
NSString *const URL_MORE_REPLY_MSG = @"/msg/reply.action";
NSString *const URL_MORE_DELETE_MSG = @"/msg/delete.action";

NSString *const URL_MEETTING_LIST = @"/meetingroom/list.do";
NSString *const URL_MEETTING_P2P = @"/meetingroom/invite_p2p.do";
NSString *const URL_MEETTING_CREAT = @"/meeting/create.action";
NSString *const URL_MEETTING_INVITE = @"/meeting/invite.action";

NSString *const URL_CLASS_LIST = @"/lesson/list.action";
NSString *const URL_CLASS_LIST_TYPE = @"/lesson/list.action";

NSString *const URL_BUSINESS_CRIMEAPPLY = @"/crimeApply/saveCrimeApplyInfo.action";
NSString *const URL_BUSINESS_TOAPPLYID = @"/crimeApply/findCommentsInfoToapplyid.action";
NSString *const URL_BUSINESS_REVIEW = @"/crimeApply/reviewCommentsInfoToUserinfo.action";
NSString *const URL_BUSINESS_DEPT = @"/crimeApply/findCommentsInfoToDept.action";
NSString *const URL_BUSINESS_READ = @"/learnRecord/saveReadLearnRecor.action";
NSString *const URL_BUSINESS_FIND_READ = @"/learnRecord/findReadLearnRecor.action";
