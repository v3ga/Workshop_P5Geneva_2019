class GridCellRenderEllipse extends GridCellRender implements CallbackListener
{
  // ----------------------------------------------------------
  // Parameters
  // Number of points for the ellipse polygon (3 is a triangle, 4 a quad :)
  int res = 20;
  // Scale along x,y axis
  float scalex = 1.0, scaley = 1.0;

  // ----------------------------------------------------------
  // Controls
  Slider sliderEllipseRes, sliderEllipseScalex, sliderEllipseScaley;

  // ----------------------------------------------------------
  GridCellRenderEllipse(Grid grid)
  {
    super("Ellipses", grid);
    this.grid = grid;
  }

  // ----------------------------------------------------------
  void compute(Rect rect, Polygon2D quad)
  {
    // Center of rect
    Vec2D c = new Vec2D(rect.x+0.5*rect.width, rect.y+0.5*rect.height);

    // Ellipse
    Polygon2D ellipse = new Ellipse(c, new Vec2D(this.scalex*grid.wCell/2, this.scaley*grid.hCell/2)).toPolygon2D(this.res); 

    // Fit ellipse into quad
    Polygon2D ellipsePertubation = constrainIntoQuad(ellipse, rect, quad);
    
    // Add to polygons list
    listPolygons.add(  ellipsePertubation );
  
    // Stripes ? 
    if (grid.bComputeStripes)
      computeStripes(ellipsePertubation, grid.stripesAngleStrategy, grid.getFieldValue( ellipse.getCentroid() ) );
  }

  // ----------------------------------------------------------
  void drawDirect(Rect rect, int i, int j)
  {
    pushStyle();
    noFill();
    stroke(colorStroke);
    ellipse(rect.x+0.5*rect.width, rect.y+0.5*rect.height, this.scalex*rect.width, this.scaley*rect.height);  
    popStyle();
  }


// ----------------------------------------------------------
  void createControls()
  {
    int margin = 5;
    int wControl = int(rectColumnRight.width - 2*margin)-60;
    int hControl = 20;
    int padding = 10;
    int x = 5;
    int y = 10;

    ControlP5 cp5 = controls.cp5;
    g = cp5.addGroup(this.name).setBackgroundHeight(400).setWidth(int(rectColumnRight.width)).setBackgroundColor(color(0, 190)).setPosition(rectColumnRight.x, 10);

    cp5.setBroadcast(false);
    sliderEllipseRes = cp5.addSlider( _id("res") ).setLabel("res").setPosition(x, y).setSize(wControl, hControl).setRange(3, 30).setNumberOfTickMarks(30-2).setValue(this.res).setGroup(g).addCallback(this);
    y+=(hControl+padding);
    sliderEllipseScalex = cp5.addSlider( _id("scalex") ).setLabel("scalex").setPosition(x, y).setSize(wControl, hControl).setRange(0.2, 2).setValue(this.scalex).setGroup(g).addCallback(this);
    y+=(hControl+padding);
    sliderEllipseScaley = cp5.addSlider( _id("scaley") ).setLabel("scaley").setPosition(x, y).setSize(wControl, hControl).setRange(0.2, 2).setValue(this.scaley).setGroup(g).addCallback(this);

    cp5.setBroadcast(true);
  }

  // ----------------------------------------------------------
  public void controlEvent(CallbackEvent theEvent) 
  {
    switch(theEvent.getAction()) 
    {
    case ControlP5.ACTION_RELEASED: 
    case ControlP5.ACTION_RELEASEDOUTSIDE: 
      String name = theEvent.getController().getName();
      float value = theEvent.getController().getValue();
      //      println(name + "/"+value);
      if (name.equals( _id("res") ) )
      {
        this.res = int(value);
        this.grid.bComputeGridVec = true;
      } else if (name.equals( _id("scalex") ) )
      {
        this.scalex = value;
        this.grid.bComputeGridVec = true;
      } else if (name.equals( _id("scaley") ) )
      {
        this.scaley = value;
        this.grid.bComputeGridVec = true;
      }        
      break;
    }
  }
}
