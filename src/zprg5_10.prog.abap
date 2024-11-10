*&---------------------------------------------------------------------*
*& Report ZPRG5_10
*&---------------------------------------------------------------------*
*& Absract Class Local
*&---------------------------------------------------------------------*
REPORT ZPRG5_10.

DATA : LV_ERDAT TYPE ERDAT,
       LV_ERZET TYPE ERZET,
       LV_ERNAM TYPE ERNAM,
       LV_VBTYP TYPE VBTYP.


PARAMETERS : P_VBELN TYPE VBELN_VA.
PARAMETERS : P_R1 TYPE C RADIOBUTTON GROUP R1,
             P_R2 TYPE C RADIOBUTTON GROUP R1.

CLASS ABSTRACT_CLASS DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS DISPLAY ABSTRACT IMPORTING PVBELN TYPE VBELN_VA
                             EXPORTING PERDAT TYPE ERDAT
                                       PERZET TYPE ERZET
                                       PERNAM TYPE ERNAM
                                       PVBTYP TYPE VBTYP.
ENDCLASS.
CLASS SALES DEFINITION INHERITING FROM ABSTRACT_CLASS.
  PUBLIC SECTION.
    METHODS DISPLAY REDEFINITION.
ENDCLASS.

CLASS SALES IMPLEMENTATION.
  METHOD DISPLAY.
    SELECT SINGLE ERDAT ERZET ERNAM VBTYP
    FROM VBAK
    INTO (PERDAT, PERZET, PERNAM, PVBTYP)
    WHERE VBELN = PVBELN.
  ENDMETHOD.
ENDCLASS.

CLASS BILLING DEFINITION INHERITING FROM ABSTRACT_CLASS.
  PUBLIC SECTION.
    METHODS DISPLAY REDEFINITION.
ENDCLASS.

CLASS BILLING IMPLEMENTATION.
  METHOD DISPLAY.
    SELECT SINGLE VBTYP ERNAM ERZET ERDAT
    FROM VBRK
    INTO (PVBTYP, PERNAM, PERZET, PERDAT)
    WHERE VBELN = PVBELN.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA : LO_OBJECT1 TYPE REF TO SALES.
  DATA : LO_OBJECT2 TYPE REF TO BILLING.

  IF P_R1 = 'X'.
    CREATE OBJECT LO_OBJECT1.
    LO_OBJECT1->DISPLAY( EXPORTING PVBELN = P_VBELN
                         IMPORTING PERDAT = LV_ERDAT
                                   PERZET = LV_ERZET
                                   PERNAM = LV_ERNAM
                                   PVBTYP = LV_VBTYP ).
    WRITE: 'The Sales Order Details', / LV_ERDAT,
         / LV_ERZET,
         / LV_ERNAM,
         / LV_VBTYP.
  ENDIF.

  IF P_R2 = 'X'.
    CREATE OBJECT LO_OBJECT2.
    LO_OBJECT2->DISPLAY( EXPORTING PVBELN = P_VBELN
                         IMPORTING PERDAT = LV_ERDAT
                                   PERZET = LV_ERZET
                                   PERNAM = LV_ERNAM
                                   PVBTYP = LV_VBTYP ).
    WRITE: 'The Billing Document Details', / LV_ERDAT,
         / LV_ERZET,
         / LV_ERNAM,
         / LV_VBTYP.
  ENDIF.
