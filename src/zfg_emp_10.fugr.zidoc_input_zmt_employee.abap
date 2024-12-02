FUNCTION ZIDOC_INPUT_ZMT_EMPLOYEE.
*"--------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(INPUT_METHOD) LIKE  BDWFAP_PAR-INPUTMETHD
*"     VALUE(MASS_PROCESSING) LIKE  BDWFAP_PAR-MASS_PROC
*"  EXPORTING
*"     VALUE(WORKFLOW_RESULT) LIKE  BDWF_PARAM-RESULT
*"     VALUE(APPLICATION_VARIABLE) LIKE  BDWF_PARAM-APPL_VAR
*"     VALUE(IN_UPDATE_TASK) LIKE  BDWFAP_PAR-UPDATETASK
*"     VALUE(CALL_TRANSACTION_DONE) LIKE  BDWFAP_PAR-CALLTRANS
*"  TABLES
*"      IDOC_CONTRL STRUCTURE  EDIDC
*"      IDOC_DATA STRUCTURE  EDIDD
*"      IDOC_STATUS STRUCTURE  BDIDOCSTAT
*"      RETURN_VARIABLES STRUCTURE  BDWFRETVAR
*"      SERIALIZATION_INFO STRUCTURE  BDI_SER
*"  EXCEPTIONS
*"      WRONG_FUNCTION_CALLED
*"--------------------------------------------------------------------
*----------------------------------------------------------------------*
*  this function module is generated                                   *
*          never change it manually, please!        29.11.2024         *
*----------------------------------------------------------------------*

  DATA:
      Z1BP_EMPLOYEE_10 LIKE Z1BP_EMPLOYEE_10,

      RETURN LIKE
        BAPIRET2,
      PEMPLOYEE LIKE
        ZBAPI_EMPLOYEE_10,


      T_EDIDD  LIKE EDIDD OCCURS 0 WITH HEADER LINE,
      BAPI_RETN_INFO  LIKE BAPIRET2 OCCURS 0 WITH HEADER LINE.

  DATA: ERROR_FLAG,
        BAPI_IDOC_STATUS LIKE BDIDOCSTAT-STATUS.

  IN_UPDATE_TASK = 'X'.
  CLEAR CALL_TRANSACTION_DONE.
* check if the function is called correctly                            *
  READ TABLE IDOC_CONTRL INDEX 1.
  IF SY-SUBRC <> 0.
    EXIT.
  ELSEIF IDOC_CONTRL-MESTYP <> 'ZMT_EMPLOYEE'.
    RAISE WRONG_FUNCTION_CALLED.
  ENDIF.

* go through all IDocs                                                 *
  LOOP AT IDOC_CONTRL.
*   select segments belonging to one IDoc                              *
    REFRESH T_EDIDD.
    LOOP AT IDOC_DATA WHERE DOCNUM = IDOC_CONTRL-DOCNUM.
      APPEND IDOC_DATA TO T_EDIDD.
    ENDLOOP.

*   through all segments of this IDoc                                  *
    CLEAR ERROR_FLAG.
    REFRESH BAPI_RETN_INFO.
    CATCH SYSTEM-EXCEPTIONS CONVERSION_ERRORS = 1.
      LOOP AT T_EDIDD INTO IDOC_DATA.

        CASE IDOC_DATA-SEGNAM.

          WHEN 'Z1BP_EMPLOYEE_10'.

            Z1BP_EMPLOYEE_10 = IDOC_DATA-SDATA.
            MOVE-CORRESPONDING Z1BP_EMPLOYEE_10
               TO PEMPLOYEE.                                "#EC ENHOK


        ENDCASE.

      ENDLOOP.
    ENDCATCH.
    IF SY-SUBRC = 1.
*     write IDoc status-record as error and continue                   *
      CLEAR BAPI_RETN_INFO.
      BAPI_RETN_INFO-TYPE   = 'E'.
      BAPI_RETN_INFO-ID     = 'B1'.
      BAPI_RETN_INFO-NUMBER = '527'.
      BAPI_RETN_INFO-MESSAGE_V1 = IDOC_DATA-SEGNAM.
      BAPI_IDOC_STATUS      = '51'.
      PERFORM ZIDOC_STATUS_ZMT_EMPLOYEE
              TABLES T_EDIDD
                     IDOC_STATUS
                     RETURN_VARIABLES
               USING IDOC_CONTRL
                     BAPI_RETN_INFO
                     BAPI_IDOC_STATUS
                     WORKFLOW_RESULT.
      CONTINUE.
    ENDIF.
*   call BAPI-function in this system                                  *
    CALL FUNCTION 'ZBAPI_EMPLOYEE_CREATE'
       EXPORTING
        PEMPLOYEE = PEMPLOYEE
       IMPORTING
        RETURN = RETURN
       EXCEPTIONS
        OTHERS =  1
         .
    IF SY-SUBRC <> 0.
*     write IDoc status-record as error                                *
      CLEAR BAPI_RETN_INFO.
      BAPI_RETN_INFO-TYPE       = 'E'.
      BAPI_RETN_INFO-ID         = SY-MSGID.
      BAPI_RETN_INFO-NUMBER     = SY-MSGNO.
      BAPI_RETN_INFO-MESSAGE_V1 = SY-MSGV1.
      BAPI_RETN_INFO-MESSAGE_V2 = SY-MSGV2.
      BAPI_RETN_INFO-MESSAGE_V3 = SY-MSGV3.
      BAPI_RETN_INFO-MESSAGE_V4 = SY-MSGV4.
      BAPI_IDOC_STATUS          = '51'.
      PERFORM ZIDOC_STATUS_ZMT_EMPLOYEE
              TABLES T_EDIDD
                     IDOC_STATUS
                     RETURN_VARIABLES
               USING IDOC_CONTRL
                     BAPI_RETN_INFO
                     BAPI_IDOC_STATUS
                     WORKFLOW_RESULT.
    ELSE.
      IF NOT RETURN IS INITIAL.
        CLEAR BAPI_RETN_INFO.
        MOVE-CORRESPONDING RETURN
             TO BAPI_RETN_INFO.                             "#EC ENHOK
        IF RETURN-TYPE = 'A' OR
           RETURN-TYPE = 'E'.
          ERROR_FLAG = 'X'.
        ENDIF.
        APPEND BAPI_RETN_INFO.
      ENDIF.
      LOOP AT BAPI_RETN_INFO.
*       write IDoc status-record                                       *
        IF ERROR_FLAG IS INITIAL.
          BAPI_IDOC_STATUS = '53'.
        ELSE.
          BAPI_IDOC_STATUS = '51'.
          IF BAPI_RETN_INFO-TYPE = 'S'.
            CONTINUE.
          ENDIF.
        ENDIF.
        PERFORM ZIDOC_STATUS_ZMT_EMPLOYEE
                TABLES T_EDIDD
                       IDOC_STATUS
                       RETURN_VARIABLES
                 USING IDOC_CONTRL
                       BAPI_RETN_INFO
                       BAPI_IDOC_STATUS
                       WORKFLOW_RESULT.
      ENDLOOP.
      IF SY-SUBRC <> 0.
*      'RETURN'                                                        *
*       is empty write idoc status-record as successful                *
        CLEAR BAPI_RETN_INFO.
        BAPI_RETN_INFO-TYPE       = 'S'.
        BAPI_RETN_INFO-ID         = 'B1'.
        BAPI_RETN_INFO-NUMBER     = '501'.
        BAPI_RETN_INFO-MESSAGE_V1 = 'CREATE'.
        BAPI_IDOC_STATUS          = '53'.
        PERFORM ZIDOC_STATUS_ZMT_EMPLOYEE
                TABLES T_EDIDD
                       IDOC_STATUS
                       RETURN_VARIABLES
                 USING IDOC_CONTRL
                       BAPI_RETN_INFO
                       BAPI_IDOC_STATUS
                       WORKFLOW_RESULT.
      ENDIF.
      IF ERROR_FLAG IS INITIAL.
*       write linked object keys                                       *
        CLEAR RETURN_VARIABLES.
        RETURN_VARIABLES-WF_PARAM = 'Appl_Objects'.
      ENDIF.
    ENDIF.

  ENDLOOP.                             " idoc_contrl






ENDFUNCTION.


* subroutine writing IDoc status-record                                *
FORM ZIDOC_STATUS_ZMT_EMPLOYEE
     TABLES IDOC_DATA    STRUCTURE  EDIDD
            IDOC_STATUS  STRUCTURE  BDIDOCSTAT
            R_VARIABLES  STRUCTURE  BDWFRETVAR
      USING IDOC_CONTRL  LIKE  EDIDC
            VALUE(RETN_INFO) LIKE   BAPIRET2
            STATUS       LIKE  BDIDOCSTAT-STATUS
            WF_RESULT    LIKE  BDWF_PARAM-RESULT.

  CLEAR IDOC_STATUS.
  IDOC_STATUS-DOCNUM   = IDOC_CONTRL-DOCNUM.
  IDOC_STATUS-MSGTY    = RETN_INFO-TYPE.
  IDOC_STATUS-MSGID    = RETN_INFO-ID.
  IDOC_STATUS-MSGNO    = RETN_INFO-NUMBER.
  IDOC_STATUS-APPL_LOG = RETN_INFO-LOG_NO.
  IDOC_STATUS-MSGV1    = RETN_INFO-MESSAGE_V1.
  IDOC_STATUS-MSGV2    = RETN_INFO-MESSAGE_V2.
  IDOC_STATUS-MSGV3    = RETN_INFO-MESSAGE_V3.
  IDOC_STATUS-MSGV4    = RETN_INFO-MESSAGE_V4.
  IDOC_STATUS-REPID    = SY-REPID.
  IDOC_STATUS-STATUS   = STATUS.

  CASE RETN_INFO-PARAMETER.
    WHEN 'PEMPLOYEE'
         .
      LOOP AT IDOC_DATA WHERE
                        SEGNAM = 'Z1BP_EMPLOYEE_10'.
        RETN_INFO-ROW = RETN_INFO-ROW - 1.
        IF RETN_INFO-ROW <= 0.
          IDOC_STATUS-SEGNUM = IDOC_DATA-SEGNUM.
          IDOC_STATUS-SEGFLD = RETN_INFO-FIELD.
          EXIT.
        ENDIF.
      ENDLOOP.
    WHEN OTHERS.

  ENDCASE.

  INSERT IDOC_STATUS INDEX 1.

  IF IDOC_STATUS-STATUS = '51'.
    WF_RESULT = '99999'.
    R_VARIABLES-WF_PARAM   = 'Error_IDOCs'.
    R_VARIABLES-DOC_NUMBER = IDOC_CONTRL-DOCNUM.
    READ TABLE R_VARIABLES FROM R_VARIABLES.
    IF SY-SUBRC <> 0.
      APPEND R_VARIABLES.
    ENDIF.
  ELSEIF IDOC_STATUS-STATUS = '53'.
    CLEAR WF_RESULT.
    R_VARIABLES-WF_PARAM = 'Processed_IDOCs'.
    R_VARIABLES-DOC_NUMBER = IDOC_CONTRL-DOCNUM.
    READ TABLE R_VARIABLES FROM R_VARIABLES.
    IF SY-SUBRC <> 0.
      APPEND R_VARIABLES.
    ENDIF.
    R_VARIABLES-WF_PARAM = 'Appl_Object_Type'.
    R_VARIABLES-DOC_NUMBER = 'ZEMPLOYEE'.
    READ TABLE R_VARIABLES FROM R_VARIABLES.
    IF SY-SUBRC <> 0.
      APPEND R_VARIABLES.
    ENDIF.
  ENDIF.

ENDFORM.                               " ZIDOC_STATUS_ZMT_EMPLOYEE
