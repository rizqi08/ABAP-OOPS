*&---------------------------------------------------------------------*
*& Report ZPRG1_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPRG1_10.
DATA : LV_ERDAT TYPE ERDAT,
       LV_ERZET TYPE ERZET,
       LV_ERNAM TYPE ERNAM,
       LV_VBTYP TYPE VBTYP.
DATA : LO_OBJECT TYPE REF TO ZUSUAL_ABAP_CLASS.

PARAMETERS : P_VBELN TYPE VBELN_VA.

"Static Method (menggunakan operator '=>' tidak perlu create object)
"------------------------------------------------
CALL METHOD ZUSUAL_ABAP_CLASS=>DISPLAY
  EXPORTING
    PVBELN      = P_VBELN
  IMPORTING
    PERDAT      = LV_ERDAT
    PERZET      = LV_ERZET
    PERNAM      = LV_ERNAM
    PVBTYP      = LV_VBTYP
  EXCEPTIONS
    WRONG_INPUT = 1
    OTHERS      = 2.
IF SY-SUBRC <> 0.
  MESSAGE 'Input not correct' TYPE 'E'.
ELSE.
  WRITE:/ LV_ERDAT,
        / LV_ERZET,
        / LV_ERNAM,
        / LV_VBTYP.
ENDIF.

"Instance Method (menggunakan operator '->' dan harus create object)
"------------------------------------------------
*CREATE OBJECT LO_OBJECT.
*
*CALL METHOD LO_OBJECT->DISPLAY
*  EXPORTING
*    PVBELN      = P_VBELN
*  IMPORTING
*    PERDAT      = LV_ERDAT
*    PERZET      = LV_ERZET
*    PERNAM      = LV_ERNAM
*    PVBTYP      = LV_VBTYP
*  EXCEPTIONS
*    WRONG_INPUT = 1
*    OTHERS      = 2.
*IF SY-SUBRC <> 0.
*  MESSAGE 'Input not correct' TYPE 'E'.
*ELSE.
*  WRITE:/ LV_ERDAT,
*        / LV_ERZET,
*        / LV_ERNAM,
*        / LV_VBTYP.
*ENDIF.
