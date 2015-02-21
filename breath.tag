<breath>
  <div class={ hidden: cycle.status == 'done'}>

    <div class={ hidden: cycle.status != 'waiting' } >
      <button
        onclick={ start }
        class="btn btn-primary btn-lg btn-block"
      >
        { cycle.btn_caption }
      </button>
    </div>

    <h2 class="text-center">
      <div class={ hidden: cycle.status == 'done' } >
        { cycle.action }
        <span class={ hidden: cycle.status != 'started' } >
          ({ cycle.count } / 4)
        </span>
      </div>
    </h2>

    <div class="text-center counter { cycle.current }">
      { timer.countdown }
    </div>
  </div>

  <div class={ hidden: cycle.status != 'done'}>
    <p class="bg-success">
      <strong>That's it</strong>
      You are done with the exercise. Do this exercise at leat twice a day.
    </p>

  </div>

  this.cycle = {
    action: 'ready',
    btn_caption: 'Start breathing cycle',
    status: 'waiting',
    current: ''
  };

  this.timer = {
    countdown: 'Waiting'
  };

  start(e) {
    this.cycle.count = 1;
    this.cycle.status = 'started'
    this.inhale();
  }

  done() {
    if(this.cycle.count < 4){
      this.cycle.count++;
      this.inhale();
    }
    else{
      this.cycle.status = 'done';
    }
  }

  inhale() {
    this.cycle.current = 'inhale';
    this.cycle.action = 'Inhale through your nose';
    this.timer(4, this.hold);
  }

  hold() {
    this.cycle.current = 'hold';
    this.cycle.action = 'Hold your breath';
    this.timer(7, this.exhale);
  }

  exhale() {
    this.cycle.current = 'exhale';
    this.cycle.action = 'Exhale through your mouth';
    this.timer(8, this.done);
  }

  timer(time, callback) {
    var start = new Date().getTime();

    var timer = this.timer;
    var update = this.update;

    timer.countdown = time;


    var interval = setInterval(function(){
      var now = new Date().getTime();

      var seconds = parseInt((now - start) / 1000, 10);

      timer.countdown = time - seconds;
      update();

      if (seconds >= time){
        clearInterval(interval);
        setTimeout(callback,0);
      }
    }, 100);
  }

</breath>
