REPORT ZRADIOBUTTON.

************************ RADIO BUTTON WHICH VANISH IF ONE OF THE FIELD IS SELECTED.*******************************

TABLES: vbak.

DATA :GT_VBAK TYPE TABLE OF VBAK, " INTERNAL TABBLE DECLARATION
      GS_VBAK TYPE VBAK. " WORK AREA DECLARATION.

SELECTION-SCREEN : BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-000.
PARAMETERS: MALE RADIOBUTTON GROUP m1 USER-COMMAND RAH .
SELECT-OPTIONS:SO_VBELN FOR VBAK-VBELN MODIF ID c1.

PARAMETERS: FEMALE RADIOBUTTON GROUP m1 DEFAULT 'X'.
SELECT-OPTIONS:SO_BSTNK FOR VBAK-BSTNK MODIF ID c2.
SELECTION-SCREEN : END OF BLOCK B1 .
AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-group1 = 'C1'.
      IF FEMALE ='X'.

        screen-active = 0.
      ELSE.
        screen-active = 1.
      ENDIF.

    ENDIF.

    IF screen-group1 = 'C2'.
      IF MALE ='X'.
        screen-active = 0.
      ELSE.
        screen-active = 1.
      ENDIF.
    ENDIF.
  MODIFY SCREEN.

  ENDLOOP.

****** FETCH DATA**********
START-OF-SELECTION.

  IF MALE = 'X'.
    SELECT *
      FROM VBAK
      INTO TABLE GT_VBAK
      WHERE VBELN IN SO_VBELN.

  ENDIF.


  IF FEMALE = 'X'.
    SELECT *
      FROM VBAK
      INTO TABLE GT_VBAK
      WHERE BSTNK IN SO_BSTNK.

  ENDIF.

  END-OF-SELECTION.


*********DISPLAY DATA*************

LOOP AT GT_VBAK INTO GS_VBAK.
  WRITE : / GS_VBAK-VBELN,GS_VBAK-BSTNK,GS_VBAK-ERDAT,GS_VBAK-ERNAM,GS_VBAK-ERZET.

  ENDLOOP.