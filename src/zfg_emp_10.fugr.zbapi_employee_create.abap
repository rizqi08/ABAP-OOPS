FUNCTION ZBAPI_EMPLOYEE_CREATE.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(PEMPLOYEE) TYPE  ZBAPI_EMPLOYEE_10
*"  EXPORTING
*"     VALUE(RETURN) TYPE  BAPIRET2
*"----------------------------------------------------------------------

"NOTES : by-Meisani
*Prasyarat untuk BAPI (untuk RFC)
*"----------------------------------------------------------------------
*->Nama modul fungsi harus dimulai dengan <namespace>BAPI_<business_object>_<method>.
*->Semua parameter terkait tipe harus dimulai dengan <namespace>BAPI.
*->Semua parameter harus diteruskan dengan nilai (pass by value).
*->Harus ada parameter RETURN dengan tipe 'BAPIRET2'.
*->Modul fungsi harus RFC-enabled.
*->Modul fungsi harus diReleased

  DATA : LWA_EMPLOYEE TYPE ZTEMPLOYEE_10.

  LWA_EMPLOYEE-EID = PEMPLOYEE-EID.
  LWA_EMPLOYEE-ENAME = PEMPLOYEE-ENAME.

  INSERT ZTEMPLOYEE_10 FROM LWA_EMPLOYEE.
  IF SY-SUBRC = 0.
    RETURN-TYPE = 'S'.
    RETURN-ID = 'ZABAP'.
    RETURN-NUMBER = '004'.
    RETURN-MESSAGE_V1 = PEMPLOYEE-EID.
  ELSE.
    RETURN-TYPE = 'E'.
    RETURN-ID = 'ZABAP'.
    RETURN-NUMBER = '005'.
    RETURN-MESSAGE_V1 = PEMPLOYEE-EID.
  ENDIF.

ENDFUNCTION.
