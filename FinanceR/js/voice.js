
function debug(text)
{
  console.log(text);
}

function chart(text)
{
  $('#sales-forecast').show().html('chart');
}

function forecast(text)
{
  // alert('forecast');
  $('#sales-forecast').show().html('forecast');
}

function downloadReport()
{
    // download
    var link = document.createElement("a");
    link.download = 'report';
    link.href = 'img/report.png';
    link.click();
}

function changeColor(text)
{
    // 填充颜色转换 代码
    $('#sales-forecast').show().html(text);
}

var initVoice = function(commands, annyang, isDebug) 
{
    if (annyang) {
       console.log('running Voice');
      // Add our commands to annyang
      annyang.addCommands(commands);
      annyang.debug(isDebug);

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
        console.log(userSaid); // sample output: 'hello'
        console.log(commandText); // sample output: 'hello (there)'
        console.log(phrases); // sample output: ['hello', 'halo', 'yellow', 'polo', 'hello kitty']
      });
    }
}

function voiceButton(annyang)
{
    if (annyang) {
        // Tell KITT to use annyang
        SpeechKITT.annyang();

        // Define a stylesheet for KITT to use
        SpeechKITT.setStylesheet('css/flat.css');

        // Render KITT's interface
        SpeechKITT.vroom();
        SpeechKITT.startRecognition();
    }
}



function runVoice()
{
    isDebug = false;
  // loadAnnyang();
  voiceButton(annyang);
  var commands = {
    'chart': function(text) {
       if (isDebug) debug('chart model');
       chart(text);
    },
    'forecast': function(text) {
       if (isDebug) debug('forecast model');
       forecast(text);
    },
    'download': function(text) {
        if (isDebug) debug('download model');
        downloadReport(text);
    },
    'color *color': function(text) {
        if (isDebug) debug('color model');
        changeColor(text);
    }
  };
  setTimeout(initVoice(commands, annyang, isDebug), 5);
}
