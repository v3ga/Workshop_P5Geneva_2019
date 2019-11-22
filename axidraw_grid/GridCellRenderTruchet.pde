class GridCellRenderTruchet extends GridCellRender implements CallbackListener
{
  // ----------------------------------------------------------
  // Parameters

  // ----------------------------------------------------------
  // Controls

  // ----------------------------------------------------------
  GridCellRenderTruchet()
  {
    super("Truchet");
  }

  // ----------------------------------------------------------
  void drawDirect(Rect rect, int i, int j)
  {
    pushStyle();
    stroke(colorStroke);

    // Choose random value
    int r = int(map( getGridFieldValue(rect.x, rect.y), 0.0, 1.0, 0.0, 4.0 ));

    float x = rect.x;
    float y = rect.y;
    float w = rect.width;
    float h = rect.height;

    if (r == 0)
    {
      line(x, y, x+w, y+h);
    } else if (r == 1)
    {
      line(x, y+h, x+w, y);
    } else if (r == 2)
    {
      line(x+w/2, y, x+w/2, y+h);
    } else if (r == 3)
    {
      line(x, y+h/2, x+w, y+h/2);
    }

    popStyle();
  }

  // ----------------------------------------------------------
  public void controlEvent(CallbackEvent theEvent) 
  {
  }
}

class GridCellRenderTruchet_1 extends GridCellRender implements CallbackListener
{
  // ----------------------------------------------------------
  // Parameters

  // ----------------------------------------------------------
  // Controls

  // ----------------------------------------------------------
  GridCellRenderTruchet_1()
  {
    super("Truchet_1");
  }

  // ----------------------------------------------------------
  void drawDirect(Rect rect, int i, int j)
  {
    // Choose random value
    int r = int(map( grid.getFieldValue(rect.x, rect.y), 0.0, 1.0, 0.0, 4.0 ));

    float x = rect.x;
    float y = rect.y;
    float w = rect.width;
    float h = rect.height;

    if (r == 0)
    {
      line(x, y, x+w, y+h);
    } else if (r == 1)
    {
      line(x, y+h, x+w, y);
    } else if (r == 2)
    {
      line(x+w/2, y, x+w/2, y+h);
    } else if (r == 3)
    {
      line(x, y+h/2, x+w, y+h/2);
    }
  }

  // ----------------------------------------------------------
  public void controlEvent(CallbackEvent theEvent) 
  {
  }
}
