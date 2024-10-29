*&---------------------------------------------------------------------*
*& Report ZPRG2_10
*&---------------------------------------------------------------------*
*& Using Local Class
*&---------------------------------------------------------------------*
REPORT ZPRG2_10.
DATA : LV_ERDAT TYPE ERDAT,
       LV_ERZET TYPE ERZET,
       LV_ERNAM TYPE ERNAM,
       LV_VBTYP TYPE VBTYPL.

PARAMETERS P_VBELN TYPE VBELN_VA.

** INSTANCE METHOD
** ------------------------------------------------------- *
*CLASS CLASS1 DEFINITION.
*  PUBLIC SECTION.
*    METHODS DISPLAY IMPORTING  PVBELN TYPE VBELN_VA
*                    EXPORTING  PERDAT TYPE ERDAT
*                               PERZET TYPE ERZET
*                               PERNAM TYPE ERNAM
*                               PVBTYP TYPE VBTYPL
*                    EXCEPTIONS WRONG_INPUT.
*ENDCLASS.
*
*CLASS CLASS1 IMPLEMENTATION.
*  METHOD DISPLAY.
*    SELECT SINGLE ERDAT ERZET ERNAM VBTYP
*    FROM VBAK
*    INTO (PERDAT, PERZET, PERNAM, PVBTYP)
*    WHERE VBELN = P_VBELN.
*
*    IF SY-SUBRC <> 0.
*      RAISE WRONG_INPUT.
*    ENDIF.
*  ENDMETHOD.
*ENDCLASS.
*
*START-OF-SELECTION.
*  DATA : LO_OBJECT TYPE REF TO CLASS1.
*
*  CREATE OBJECT LO_OBJECT.
*  LO_OBJECT->DISPLAY( EXPORTING  PVBELN      = P_VBELN
*                      IMPORTING  PERDAT      = LV_ERDAT
*                                 PERZET      = LV_ERZET
*                                 PERNAM      = LV_ERNAM
*                                 PVBTYP      = LV_VBTYP
*                      EXCEPTIONS WRONG_INPUT = 1 ).

* STATIC METHOD
* ------------------------------------------------------- *
CLASS CLASS1 DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS DISPLAY IMPORTING  PVBELN TYPE VBELN_VA
                          EXPORTING  PERDAT TYPE ERDAT
                                     PERZET TYPE ERZET
                                     PERNAM TYPE ERNAM
                                     PVBTYP TYPE VBTYPL
                          EXCEPTIONS WRONG_INPUT.
ENDCLASS.

CLASS CLASS1 IMPLEMENTATION.
  METHOD DISPLAY.
    SELECT SINGLE ERDAT ERZET ERNAM VBTYP
    FROM VBAK
    INTO (PERDAT, PERZET, PERNAM, PVBTYP)
    WHERE VBELN = P_VBELN.

    IF SY-SUBRC <> 0.
      RAISE WRONG_INPUT.
    ENDIF.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  CLASS1=>DISPLAY( EXPORTING  PVBELN      = P_VBELN
                   IMPORTING  PERDAT      = LV_ERDAT
                              PERZET      = LV_ERZET
                              PERNAM      = LV_ERNAM
                              PVBTYP      = LV_VBTYP
                   EXCEPTIONS WRONG_INPUT = 1 ).

  IF SY-SUBRC = 0.
    WRITE : / LV_ERDAT,
    / LV_ERZET,
    / LV_ERNAM,
    / LV_VBTYP.
  ELSE.
    MESSAGE 'Input is not Correct' TYPE 'E'.
  ENDIF.
