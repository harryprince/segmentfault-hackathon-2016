function downloadReport()
{
    // download
    var link = document.createElement("a");
    link.download = 'report';
    link.href = 'http://image.evget.com/images/thumbnails/332/1974_1.jpg';
    link.click();
}


function debug(text)
{
  console.log(text);
}



var initVoice = function() {

   var isDebug = true; 

  if (annyang) {
    var left = 10;
    var bigger = 1;
    Shiny.onInputChange('left', '10');
    Shiny.onInputChange('title', 'say title something');
    Shiny.onInputChange('chart', 'FALSE');
    Shiny.onInputChange('color', 'black');
    Shiny.onInputChange('forecast', 'FALSE');
    Shiny.onInputChange('bigger', 1);
    Shiny.onInputChange('yes', 'no');
    $('#chart').hide();
    $('#forecast').hide();
    var commands = {
      'title *title': function(title) {
        Shiny.onInputChange('title', title);
      },
      'hide the :chart': function(chart) {
        $('#'+chart).hide();
        
        SpeechKITT.setInstructionsText(chart);
        
        if (isDebug) debug(chart + 'model');
        // Shiny.onInputChange('chart', "TRUE"); 
      },
      'show the :chart': function(chart) {
        $('#' + chart).show(); 
        SpeechKITT.setInstructionsText(chart);
        
        if (isDebug) debug(chart + 'model');
        // Shiny.onInputChange('chart', "TRUE"); 
      },
      'color :color': function(color) {
        SpeechKITT.setInstructionsText("color " + color);
        if (isDebug) debug('color model');
        console.log(color);
        
        Shiny.onInputChange('color', color);
      },
      // 'show forecast': function(forecast) {
    //    $('#table').hide();
      //  $('#trend').hide(function(){
        // $('#forecast').show();
        //});
        //SpeechKITT.setInstructionsText("forecast");
        //Shiny.onInputChange('forecast', "TRUE");
      //},
      'bigger': function() {
        bigger += 1;
        Shiny.onInputChange('bigger', bigger);
      },
      'left':function(){
          left += 10;
          Shiny.onInputChange('left',left);
          $('#trend').animate({"left": left + 'px'},"slow");
      },
      'smaller': function() {
        if (bigger >= 1.5) {
          bigger -= 1;
          Shiny.onInputChange('bigger', bigger);
        }
      },
          'download': function(text) {
        if (isDebug) debug('download model');
        downloadReport(text);
    },
      'regression': function() {
        Shiny.onInputChange('yes', Math.random());
      }
    };

    
    annyang.addCommands(commands);
    annyang.debug(true);

      annyang.addCallback('start', function() {
        console.log('starting.....');
      });

      annyang.addCallback('error', function() {
        console.log('There was an error');
      });

      annyang.addCallback('errorNetwork', function(){
          console.log('There was an errorNetwork');
      }, this);

      annyang.addCallback('resultMatch', function(userSaid, commandText, phrases) {
        console.log("userSaid",userSaid); // sample output: 'hello'
        //SpeechKITT.setInstructionsText(userSaid);
        console.log("commandText",commandText); // sample output: 'hello (there)'    
        console.log("phrases",phrases); // sample output: ['hello', 'halo', 'yellow', 'polo', 'hello kitt
      });
    
    //annyang.start();

  // Define a stylesheet for KITT to use

  // Render KITT's interface
  
  }
};


var launchVoice = function() {
    if (annyang) {
  // Add our commands to annyang

  // Tell KITT to use annyang
  SpeechKITT.annyang();

  // Define a stylesheet for KITT to use
  SpeechKITT.setStylesheet('//cdnjs.cloudflare.com/ajax/libs/SpeechKITT/0.3.0/themes/flat.css');

  // Render KITT's interface
  SpeechKITT.vroom();
  SpeechKITT.startRecognition();
  }

}

$(function() {
  setTimeout(initVoice, 5);
  setTimeout(launchVoice, 5);
  
  
});
