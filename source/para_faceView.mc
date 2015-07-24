using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;


// para_watch Version 0.92
// AWI 14.07.2015
// shows different paraglidercolors depending to activity status
// shows bluetooth indicator
// shows trophy System from AWI dotface
// shows battery status
// shows time in 12 & 24h mode
// shows date
// have fun!
// ispamsammler@googlemail.com

// V0.92 16.07.2015
// added Sun & Moon (light) as second indicator
// bugfix 12AM 12 o'clock. it's 12 PM ... damn 12h System!
// added new trophy-icons as birds instead of trophys

        

class para_faceView extends Ui.WatchFace {
var pic_back, pic_pilot,pic_dayone, pic_daythree, pic_dayfive, pic_dayseven, pic_bt, pic_nobt;
var device_settings;
    // This ARRAY comes from SectorWatch Project (GitHub) Thx!
    const min_array = [ [109,   0], [120,   1], [132,   2], [143,   5], [153,   9],
                         [164,  15], [173,  21], [182,  28], [190,  36], [197,  45],
                         [203,  55], [209,  65], [213,  75], [216,  86], [217,  98],
                         [218, 109], [217, 120], [216, 132], [213, 143], [209, 153],
                         [203, 164], [197, 173], [190, 182], [182, 190], [173, 197],
                         [164, 203], [153, 209], [143, 213], [132, 216], [120, 217],
                         [109, 218], [ 98, 217], [ 86, 216], [ 75, 213], [ 65, 209],
                         [ 55, 203], [ 45, 197], [ 36, 190], [ 28, 182], [ 21, 173],
                         [ 15, 164], [  9, 153], [  5, 143], [  2, 132], [  1, 120],
                         [  0, 109], [  1,  98], [  2,  86], [  5,  75], [  9,  65],
                         [ 15,  55], [ 21,  45], [ 28,  36], [ 36,  28], [ 45,  21],
                         [ 55,  15], [ 65,   9], [ 75,   5], [ 86,   2], [ 98,   1] ];
    var fast_updates = true;
    var activproz;
    var activ_alt = null;    
    var moveBarLevel= 0;

    //! Load your resources here
    function onLayout(dc) {
    device_settings = Sys.getDeviceSettings(); 
     // pictures to load
     pic_dayone     = Ui.loadResource(Rez.Drawables.id_dayone);
     pic_daythree   = Ui.loadResource(Rez.Drawables.id_daythree);     
     pic_dayfive    = Ui.loadResource(Rez.Drawables.id_dayfive);     
     pic_dayseven   = Ui.loadResource(Rez.Drawables.id_dayseven);
     pic_bt         = Ui.loadResource(Rez.Drawables.id_bt); 
     pic_nobt       = Ui.loadResource(Rez.Drawables.id_nobt);  
     pic_pilot      = Ui.loadResource(Rez.Drawables.id_pilot);
     } 
    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
      // black is beautiful CLEAR the screen.
      dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
      dc.clear();  
      var batt = Sys.getSystemStats().battery;
          batt = batt.toNumber();  
      

      // Para_image als Activity indicator        
      var activity = ActivityMonitor.getInfo();
      moveBarLevel = activity.moveBarLevel;
      var stepsGoal = activity.stepGoal;
      var stepsLive = activity.steps; 
          activproz = ( ( ( 100 * activity.steps.toFloat() ) / activity.stepGoal ) );
          if (activ_alt != activproz){        
           pic_back = null;
           activ_alt = activproz;
            if (activproz >= 100) {
                pic_back     = Ui.loadResource(Rez.Drawables.id_green);
            } else if (activproz >= 75) {
                pic_back     = Ui.loadResource(Rez.Drawables.id_blue);
            } else if (activproz >= 60) {
                pic_back     = Ui.loadResource(Rez.Drawables.id_black);
            } else if (activproz >= 40) {
                pic_back     = Ui.loadResource(Rez.Drawables.id_yellow);    
            } else if (activproz >= 25) {
                pic_back     = Ui.loadResource(Rez.Drawables.id_pink);
            } else {
               pic_back     = Ui.loadResource(Rez.Drawables.id_red);
            }
            }                      
        dc.drawBitmap(4, 4, pic_back); // Para zeichnen
        dc.drawBitmap(109, 130, pic_pilot); // Pilot zeichnen

        // steierleinen (grau) zeichnen
        // MOVEBAR als Steuer-Linien zeigen
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawLine(50,116, 110,141);
            dc.drawLine(50,115, 110,140);
            dc.drawLine(50,114, 109,141);    
            // zweite Leine
            dc.drawLine(80,121, 117,144);
            dc.drawLine(80,120, 117,143);
            dc.drawLine(79,119, 116,144);   
            // 3. Leine        
            dc.drawLine(98,122, 118,144);
            dc.drawLine(97,121, 118,143);
            dc.drawLine(96,121, 117,144);          
            // 4. Leine        
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawLine(128,100, 134,135);
            dc.drawLine(129,101, 135,136); 
            // 5. & 6. Leine
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawLine(138,85, 134,135); 
            dc.drawLine(139,86, 135,136); 
            dc.drawLine(152,63, 136,135); 
        

        // MOVEBAR als Steuer-Linien zeigen
        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
        if (moveBarLevel >=1) {
            dc.drawLine(50,116, 110,141);
            dc.drawLine(50,115, 110,140);
            dc.drawLine(50,114, 109,141);    
        }
        if (moveBarLevel >=2) {
            dc.drawLine(80,121, 117,144);
            dc.drawLine(80,120, 117,143);
            dc.drawLine(79,119, 116,144);   
        }
        if (moveBarLevel >=3) {
            dc.drawLine(98,122, 118,144);
            dc.drawLine(97,121, 118,143);
            dc.drawLine(96,121, 117,144);          
        }
        if (moveBarLevel >=4) {
            dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawLine(128,100, 134,135);
            dc.drawLine(129,101, 135,136); 
        }
        if (moveBarLevel ==5) {
            dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawLine(138,85, 134,135); // vierte Linie
            dc.drawLine(139,86, 135,136); // vierte Linie
            dc.drawLine(152,63, 136,135); // 5. Linie
        } 
        
        // Uhrzeit anzeigen    
        var clockTime = Sys.getClockTime();
        var hour, min, time;

        min  = clockTime.min;
        hour = clockTime.hour;
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        if( !device_settings.is24Hour ) { // AM/PM anzeige
           if (hour >= 12) {
                hour = hour - 12;
                dc.drawText(dc.getWidth(), dc.getHeight()/2 -18 , Gfx.FONT_SMALL , "pm" , Gfx.TEXT_JUSTIFY_RIGHT );
                }
                else{
                dc.drawText(dc.getWidth(), dc.getHeight()/2  -18, Gfx.FONT_SMALL , "am" , Gfx.TEXT_JUSTIFY_RIGHT );
                }
            if (hour == 0) {hour = 12;}    
            hour  = Lang.format("$1$",[hour.format("%2d")]);
            min   = Lang.format("$1$",[min.format("%02d")]); 
        }
        else {            
            hour  = Lang.format("$1$",[hour.format("%02d")]);
            min   = Lang.format("$1$",[min.format("%02d")]);
        }
      
        // #########################draw TIME ####################################      
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2-8, 20 , Gfx.FONT_NUMBER_THAI_HOT , hour.toString(), Gfx.TEXT_JUSTIFY_CENTER );
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2 + 60 , 55 , Gfx.FONT_NUMBER_HOT , min.toString(), Gfx.TEXT_JUSTIFY_CENTER );
        
        //get date & display
        var dateStrings = Time.Gregorian.info( Time.now(), Time.FORMAT_MEDIUM);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var datum_print;
        if( !device_settings.is24Hour ){ //MONAT Tag oder TAG  Monat
            datum_print =    dateStrings.month.toString() + " " + dateStrings.day.toString();
        } else {
            datum_print =   dateStrings.day.toString() + " " + dateStrings.month.toString();             
        }     
        
        dc.drawText(dc.getWidth()/2, 195, Gfx.FONT_XTINY, datum_print, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(dc.getWidth() /2, 170 , Gfx.FONT_MEDIUM, dateStrings.day_of_week.toString(), Gfx.TEXT_JUSTIFY_CENTER); 

            // Sekundenanzeige mit Zusatzinfos
        if( fast_updates ) {
               
               // bluetooth
                if( device_settings.phoneConnected == true){ // bluetooth connected?
                 dc.drawBitmap(155, 155, pic_bt);
                } else {
                 dc.drawBitmap(155, 155, pic_nobt);
                }   
                        
             // draw achivements
             drawHis(dc);   
            var dateInfo = Time.Gregorian.info( Time.now(), Time.FORMAT_SHORT );
               // Sekundenpunkt
               var sec = dateInfo.sec;
               if  ( sec <= 12 ){
                    dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_YELLOW); // Sonne
                } else if ( sec <= 18 ){
                    dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_ORANGE); // Sonnenuntergang   
                } else if (sec <= 42 ) { 
                    dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY); // Mond
                } else if (sec <= 47 ) {
                    dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_ORANGE); // Sonnenaufgang
                 } else {
                     dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_YELLOW); // Sonne
               }               
               dc.fillCircle(min_array[dateInfo.sec][0],min_array[dateInfo.sec][1],13);
             
             if  ( sec <= 12 ){
                    dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED); // Sonne
                } else if ( sec <= 18 ){
                    dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_DK_RED); // Sonnenuntergang   
                } else if (sec <= 42 ) { 
                    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE); // Mond
                } else if (sec <= 47 ) {
                    dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_DK_RED); // Sonnenaufgang
                 } else {
                     dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED); // Sonne
               }
               
               dc.drawCircle(min_array[dateInfo.sec][0],min_array[dateInfo.sec][1],14);
               dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
              
               // Steps Prozent
                activproz = activproz.toNumber();
                dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT); 
                //activproz = stepsLive.toString() + "(" + activproz.toString() + "%" + ")";   
                dc.drawText(93,  6 , Gfx.FONT_XTINY,stepsLive.toString() , Gfx.TEXT_JUSTIFY_LEFT);
                dc.drawText(22,  66 , Gfx.FONT_XTINY, activproz.toString() , Gfx.TEXT_JUSTIFY_CENTER);
                dc.drawText(20 ,  80 , Gfx.FONT_TINY, "%" , Gfx.TEXT_JUSTIFY_CENTER);
                    
                
                // Batterie
               dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE); 
               dc.fillRectangle(155, 136, 20, 10); // weißer Bereich
               if (batt >= 50){dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY);}
               dc.fillRectangle(174, 139, 3, 5); // bobbel
               dc.drawRectangle(155, 136, 20, 10); // rahmen
               if (batt >= 50){dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);}
               else if (batt >= 25) {dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_ORANGE);}
               else {dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_RED);}  
               dc.fillRectangle(156, 137, (batt.toNumber() / 5 - 1),8); // Batterie Bar
               dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
               batt = batt.toString() + "%";
               dc.drawText(195,130 , Gfx.FONT_XTINY, batt , Gfx.TEXT_JUSTIFY_CENTER );
 
               // Show steps
               // Show steps and stepsGoal als numbers
               // dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
               // dc.drawText(3, 114 , Gfx.FONT_XTINY,stepsLive.toString() , Gfx.TEXT_JUSTIFY_LEFT);
               // dc.drawText(215, 114 , Gfx.FONT_XTINY, stepsGoal.toString() , Gfx.TEXT_JUSTIFY_RIGHT );                     
        } // Ende fast updates

    }
   
     // read 7 day history and get Trophys
function drawHis(dc){
  var acthis = ActivityMonitor.getHistory();
  var bruch = false;
  var j = 0; // count goals achieved in a row
  var k = 0; // count goal achieved in total within 7 days (for 0-goal pig)
  var i = 0; // Counter
  
  // LOOP at history
 for( i = 0; i < acthis.size(); i ++)
  {
      if ( (acthis[i].steps.toFloat() / acthis[i].stepGoal) >= 1 )    {
       if (!bruch) { j++;} 
       k++; //  
      } else {  
      bruch = true; // found a non achieved daily goal. so break
      } 
  }
  
  // Draw trophy
  if (j == 7) {  dc.drawBitmap(23, 133, pic_dayseven);}
  else if (j >= 5) { dc.drawBitmap(23, 133, pic_dayfive);}
  else if (j >= 3) { dc.drawBitmap(23, 133, pic_daythree);}
  else if (j >= 1) { dc.drawBitmap(23, 133, pic_dayone);}
}
    


    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
            fast_updates = true;
            Ui.requestUpdate();
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
            fast_updates = false;
              Ui.requestUpdate();
    }

}
