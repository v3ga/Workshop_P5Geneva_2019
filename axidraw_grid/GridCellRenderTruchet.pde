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
  GridCellRenderTruchet(String name)
  {
    super(name);
  }

  // ----------------------------------------------------------
  int getValueInt(float rx, float ry,  float vMin, float vMax)
  {
    return  int(map( getGridFieldValue(rx, ry), 0.0, 1.0, vMin, vMax+1.0 ));
  }
  
  // ----------------------------------------------------------
  void drawDirect(Rect rect, int i, int j)
  {
    float x = rect.x;
    float y = rect.y;
    float w = rect.width;
    float h = rect.height;
    int r = getValueInt(rect.x,rect.y,0.0,3.0);

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



  // ----------------------------------------------------------
class GridCellRenderSpaghetti extends GridCellRenderTruchet
{
  // ----------------------------------------------------------
  GridCellRenderSpaghetti()
  {
    super("Spaghetti");
  }

}
