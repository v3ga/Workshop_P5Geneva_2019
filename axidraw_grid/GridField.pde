class GridField
{
  String name = "";
  Grid grid;
  Group g;
  boolean canAnimate = false;
  boolean bAnimate = false;

  // Variables for controls layout
  int marginControl = 5;
  int wControl = int(rectColumnRight.width - 2*marginControl)-60;
  int hControl = 20;
  int paddingControl = 10;
  int xControl = 5;
  int yControl = 10;

  // ----------------------------------------------------------
  GridField(String name)
  {
    this.name = name;
  }

  // ----------------------------------------------------------
  boolean isAnimated()
  {
    return canAnimate && bAnimate;
  }

  // ----------------------------------------------------------
  void createControls()
  {
  }

  // ----------------------------------------------------------
  void beginCreateControls()
  {
    ControlP5 cp5 = controls.cp5;
    g = cp5.addGroup(this.name).setBackgroundHeight(200).setWidth(int(rectColumnRight.width)).setBackgroundColor(color(0, 190)).setPosition(rectColumnRight.x, yGridFieldControls);
  }

  // ----------------------------------------------------------
  void endCreateControls()
  {
    ControlP5 cp5 = controls.cp5;
    cp5.setBroadcast(true);
  }  

  // ----------------------------------------------------------
  void jumpLineControls()
  {
    yControl += (hControl + paddingControl);
  }

  // ----------------------------------------------------------
  void jumpLineControlsMarginAdd(int margin)
  {
    yControl += (hControl + paddingControl) + margin;
  }

  // ----------------------------------------------------------
  void handleEventReleased(String name, float val)
  {
  }

  // ----------------------------------------------------------
  public void controlEvent(CallbackEvent theEvent) 
  {
    switch(theEvent.getAction()) 
    {
    case ControlP5.ACTION_RELEASED: 
    case ControlP5.ACTION_RELEASEDOUTSIDE: 
      String name = theEvent.getController().getName();
      float val = theEvent.getController().getValue();
      this.handleEventReleased(name, val);
      break;
    }
  }

  // ----------------------------------------------------------
  void showControls()
  {
    if (g!=null)
      g.show();
  }

  // ----------------------------------------------------------
  void hideControls()
  {
    if (g!=null)
      g.hide();
  }

  // ----------------------------------------------------------
  String _id(String s)
  {
    return this.name+"_"+s;
  }

  // ----------------------------------------------------------
  float getValue(Vec2D p)
  {
    return this.getValue(p.x, p.y);
  }

  // ----------------------------------------------------------
  float getValue(float x, float y)
  {
    return 0.0;
  }

  // ----------------------------------------------------------
  void prepare()
  {
  }

  // ----------------------------------------------------------
  void update(float dt)
  {
  }

  // ----------------------------------------------------------
  void draw()
  {
  }
}

// ----------------------------------------------------------
class GridFieldConstant extends GridField implements CallbackListener
{
  float value = 0.5;
  Slider sliderValue;

  // ----------------------------------------------------------
  GridFieldConstant()
  {
    super("Constant");
  }

  // ----------------------------------------------------------
  void createControls()
  {
    beginCreateControls();

    sliderValue = controls.cp5.addSlider( _id("value") ).setLabel("value").setPosition(xControl, yControl).setSize(wControl, hControl).setRange(0, 1).setValue(this.value).setGroup(g).addCallback(this);

    endCreateControls();
  }

  // ----------------------------------------------------------
  void handleEventReleased(String name, float val)
  {
    if (name.equals( _id("value") ) )
    {
      this.value = val;
      this.grid.bComputeGridVec = true;
    }
  }

  // ----------------------------------------------------------
  float getValue(float x, float y)
  {
    return this.value;
  }
}

// ----------------------------------------------------------
class GridFieldRandom extends GridField implements CallbackListener
{
  float[][] random;

  // ----------------------------------------------------------
  GridFieldRandom()
  {
    super("Random");
  }

  // ----------------------------------------------------------
  void createControls()
  {
    beginCreateControls();

    controls.cp5.addButton(_id("generate")).setLabel("generate").setPosition(xControl, yControl).setGroup(g).addCallback(this);

    endCreateControls();
  }

  // ----------------------------------------------------------
  void handleEventReleased(String name, float val)
  {
    if (name.equals( _id("generate") ) )
    {
      this.grid.bComputeGridVec = true; // will in turn call prepare()
    }
  }

  // ----------------------------------------------------------
  void prepare()
  {
    //    println("GridfieldRandom.prepare(), grid.resx="+this.grid.resx+",grid.resy="+this.grid.resy);
    this.random = new float[this.grid.resx][this.grid.resy];
    int i, j;
    for (j=0; j<this.grid.resy; j++)
      for (i=0; i<this.grid.resx; i++)
      {
        this.random[i][j] = random(1.0);
      }
  }

  // ----------------------------------------------------------
  float getValue(float x, float y)
  {
    if (this.random != null)
    {
      int i = int ((x-this.grid.x) / this.grid.wCell);
      int j = int ((y-this.grid.y) / this.grid.hCell);
      if (i>=0 && i < this.grid.resx && j>=0 && j < this.grid.resy)
        return  this.random[i][j];
    }
    return 0.0;
  }
}


// ----------------------------------------------------------
class GridFieldSine extends GridField implements CallbackListener
{
  float nbPeriod = 1;
  Vec2D center = new Vec2D(0.5, 0.5);
  float phase = 0.0;
  float phaseSpeed = 90.0; // degrees / second

  Slider sliderNbPeriod, sliderPhaseSpeed;
  Slider2D slider2Dcenter;
  Toggle tgAnimate;

  // ----------------------------------------------------------
  GridFieldSine()
  {
    super("Sine");
    this.canAnimate = true;
  }

  // ----------------------------------------------------------
  void createControls()
  {
    beginCreateControls();

    tgAnimate = controls.cp5.addToggle(_id("animate")).setLabel("animate").setPosition(xControl, yControl).setSize(hControl, hControl).setValue(bAnimate).setGroup(g).addCallback(this);
    jumpLineControlsMarginAdd(8);
    sliderNbPeriod = controls.cp5.addSlider( _id("nbPeriod") ).setLabel("period").setPosition(xControl, yControl).setSize(wControl, hControl).setRange(0.5, 4).setValue(this.nbPeriod).setGroup(g).addCallback(this);
    jumpLineControls();
    sliderPhaseSpeed = controls.cp5.addSlider( _id("phaseSpeed") ).setLabel("phase speed").setPosition(xControl, yControl).setSize(wControl, hControl).setRange(0, 360).setValue(this.nbPeriod).setGroup(g).addCallback(this);
    jumpLineControls();
    slider2Dcenter = controls.cp5.addSlider2D( _id("center") ).setLabel("center").setPosition(xControl, yControl).setSize(wControl/2-paddingControl, wControl/2-paddingControl).setMinMax(0.0, 0.0, 1.0, 1.0).setValue(center.x, center.y).setGroup(g).addCallback(this);
    jumpLineControls();

    endCreateControls();
  }

  // ----------------------------------------------------------
  void handleEventReleased(String name, float val)
  {
    if (name.equals( _id("nbPeriod") ) )
    {
      this.nbPeriod = val;
      this.grid.bComputeGridVec = true;
    } else if (name.equals( _id("phaseSpeed") ) )
    {
      this.phaseSpeed = val;
    } else if (name.equals( _id("center") ) )
    {
      center.set(slider2Dcenter.getArrayValue()[0], slider2Dcenter.getArrayValue()[1]);
      this.grid.bComputeGridVec = true;
    }
    if (name.equals( _id("animate") ) )
    {
      this.bAnimate = val > 0.0;
    }
  }

  // ----------------------------------------------------------
  float getValue(float x, float y)
  {
    float cx = this.grid.x + center.x*this.grid.w;
    float cy = this.grid.y + center.y*this.grid.h;
    float d = dist(x, y, cx, cy) / (0.5*this.grid.w);
    return map( sin( -radians(this.phase) + d * TWO_PI * this.nbPeriod ), -1, 1, 0, 1 );
  }

  // ----------------------------------------------------------
  void update(float dt)
  {
    this.phase += this.phaseSpeed*dt;
    if (this.phase >= 360.0)
      this.phase -= 360.0;
  }
}

// ----------------------------------------------------------
class GridFieldNoise extends GridField implements CallbackListener
{
  float nbPeriod = 1;
  Slider sliderNbPeriod;

  // ----------------------------------------------------------
  GridFieldNoise()
  {
    super("Perlin Noise");
  }

  // ----------------------------------------------------------
  float getValue(float x, float y)
  {
    float cx = this.grid.x + 0.5*this.grid.w;
    float cy = this.grid.y + 0.5*this.grid.h;
    return noise( 0.01*x, 0.01*y);
  }
}

// ----------------------------------------------------------
class GridFieldGradientVertical extends GridField implements CallbackListener
{
  boolean bReverse = false;
  Toggle tgReverse;
  // ----------------------------------------------------------
  GridFieldGradientVertical()
  {
    super("vertical gradient");
  }

  // ----------------------------------------------------------
  void createControls()
  {
    beginCreateControls();
    tgReverse = controls.cp5.addToggle(_id("reverse")).setLabel("reverse").setPosition(xControl, yControl).setSize(hControl, hControl).setValue(bReverse).setGroup(g).addCallback(this);
    endCreateControls();
  }

  // ----------------------------------------------------------
  void handleEventReleased(String name, float val)
  {
    if (name.equals( _id("reverse") ) )
    {
      this.bReverse = val > 0.0;
      this.grid.bComputeGridVec = true;
    }
  }
  
  // ----------------------------------------------------------
  float getValue(float x, float y)
  {
    return map(y, grid.y, grid.y + grid.h, bReverse ? 0.0 : 1.0, bReverse ? 1.0 : 0.0);
  }
}
