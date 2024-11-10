*&---------------------------------------------------------------------*
*& Report ZPRG4_10
*&---------------------------------------------------------------------*
*& Abstract Class Global
*&---------------------------------------------------------------------*
REPORT ZPRG4_10.
DATA : LO_OBJECT1 TYPE REF TO ZSUBSALESDISPLAY_10.
DATA : LO_OBJECT2 TYPE REF TO ZSUBBILLINGDISPLAY_10.
DATA : LV_ERDAT TYPE ERDAT,
       LV_ERZET TYPE ERZET,
       LV_ERNAM TYPE ERNAM,
       LV_VBTYP TYPE VBTYP.


PARAMETERS : P_VBELN TYPE VBELN_VA.
PARAMETERS : P_R1 TYPE C RADIOBUTTON GROUP R1,
             P_R2 TYPE C RADIOBUTTON GROUP R1.

IF P_R1 = 'X'.
  CREATE OBJECT LO_OBJECT1.

  CALL METHOD LO_OBJECT1->DISPLAY
    EXPORTING
      PVBELN = P_VBELN
    IMPORTING
      PERDAT = LV_ERDAT
      PERZET = LV_ERZET
      PERNAM = LV_ERNAM
      PVBTYP = LV_VBTYP.

  WRITE: 'The Sales Order Details', / LV_ERDAT,
         / LV_ERZET,
         / LV_ERNAM,
         / LV_VBTYP.
ENDIF.

IF P_R2 = 'X'.
  CREATE OBJECT LO_OBJECT2.
  CALL METHOD LO_OBJECT2->DISPLAY
    EXPORTING
      PVBELN = P_VBELN
    IMPORTING
      PERDAT = LV_ERDAT
      PERZET = LV_ERZET
      PERNAM = LV_ERNAM
      PVBTYP = LV_VBTYP.

  WRITE: 'The Billing Document Details', / LV_ERDAT,
         / LV_ERZET,
         / LV_ERNAM,
         / LV_VBTYP.
ENDIF.
