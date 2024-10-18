*&---------------------------------------------------------------------*
*& Report ZSALES_ORDER_DISPLAY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSALES_ORDER_DISPLAY.
DATA : LO_OBJECT TYPE REF TO ZCLASS_SALES_ORDER_DETAILS,
       LT_FINAL  TYPE ZTSTR_SALES_DETAILS,
       LWA_FINAL TYPE ZSTR_SALES_DETAILS.

PARAMETERS : P_VBELN TYPE VBELN_VA.

CREATE OBJECT LO_OBJECT.

CALL METHOD LO_OBJECT->GET_DATA
  EXPORTING
    PVBELN    = P_VBELN
  IMPORTING
    LT_OUTPUT = LT_FINAL.

LOOP AT LT_FINAL INTO LWA_FINAL.
  WRITE : / LWA_FINAL-VBELN, LWA_FINAL-ERDAT, LWA_FINAL-ERZET, LWA_FINAL-ERNAM, LWA_FINAL-POSNR, LWA_FINAL-MATNR.
ENDLOOP.
