var jarallaxInit = function(){
      jarallax = new Jarallax();
      jarallax.addAnimation('#background',[{progress: "0%", top:"30%"}, {progress: "100%", top: "0%"}]);
      jarallax.addAnimation('#midground',[{progress: "0%", top:"50%"}, {progress: "100%", top: "0%"}]);
      jarallax.addAnimation('#foreground',[{progress: "0%", top:"70%"}, {progress: "100%", top: "0%"}]);
};