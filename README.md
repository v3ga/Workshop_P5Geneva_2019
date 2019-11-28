![Axidraw v3](http://v3ga.github.io/Images/Workshop_Bassens_axidraw/axidraw_v3_grid.JPG)

# Processing Geneva 2019
*Samedi 23 novembre à la HEAD, Genève*

Un événement du [Master Media Design](https://www.hesge.ch/head/formations-recherche/master-en-media-design) de la HEAD en collaboration avec le [Studio Z1](https://xy-z1.xyz/)

https://www.facebook.com/events/2395921930670293/

Processing Geneva 2019 est un événement consacré à la découverte, la célébration et l'apprentissage de la programmation dans un but créatif et artistique.
Cet événement s'adresse à la fois aux débutant·e·s n'ayant jamais touché à une ligne de code mais également aux initié·e·s ayant déjà de l'expérience en programmation.
Les ateliers seront donnés par [Julien Gachadoat](https://www.instagram.com/julienv3ga/) et [Laurent Novac](https://twitter.com/__vac__).
Des minis conférences seront également données par les intervenants et alumni·e·s Media Design !

## Outil
![Gifi](https://media.giphy.com/media/VdtYtKGy5YRPPlZMpi/giphy.gif)

## Documentation
Cet outil permet de travailler avec une grille dont les motifs sont dessinés par programme pour chaque cellule. Deux modes de rendu sont implémentés :
* **un rendu direct** qui permet d’utiliser les commandes classiques de dessin processing (line, ellipse, rect, ...)
* **un rendu "indirect"** basé sur la création de polygones. Ce mode offre des avantages de possibilités de rendu (déformation , hachures)  mais un peu plus "difficile" à programmer.

```java
boolean bModeDirect = false; // active ou non le mode direct
```
Dans son architecture, l’outil est composé de trois blocs principaux représentés par les classes décrites ci-dessous.

#### GridCellRender
Cette classe expose des méthodes pour dessiner les cellules de la grille, dans les deux modes de l’outil.
C’est principalement dans cette classe que nous allons travailler en implémentant les méthodes de dessin.
Nous pourrons aussi créer une interface graphique propice à l’expérimentation et à l’exploration combinatoire des paramètres.
##### En mode direct
C'est la méthode *drawDirect()* de la classe qui est appelé avec en paramètre : 
* [Rect](http://toxiclibs.org/docs/core/toxi/geom/Rect.html) rect //  coordonnées de la cellule dans la grille
* int i, int j // indices de la cellule (horizontal & vertical)

```java
class GridCellRenderTemplate extends GridCellRender 
{
  GridCellRenderTemplate()
  {
    super("Template");
  }

  // ----------------------------------------------------------
  void drawDirect(Rect rect, int i, int j)
  {
    pushMatrix();
    translate(rect.x, rect.y);

    line(0, 0, rect.width, rect.height);
    line(0, rect.height, rect.width, 0);
    
    popMatrix();
  }
}
```


##### En mode indirect
En mode indirect, c'est la méthode *compute()* qui est appelé pour fabriquer des instances de [Polygon2D](htPolygon2D/toxiclibs.org/docs/core/toxi/geom/Polygon2D.html) à ajouter à la liste *listPolygons* de l'instance.
Cette méthode prend deux paramètres : 
* [Rect](http://toxiclibs.org/docs/core/toxi/geom/Rect.html) rect //  coordonnées de la cellule non déformée dans la grille
* [Polygon2D](http://toxiclibs.org/docs/core/toxi/geom/Polygon2D.html) quad //  coordonnées de la cellule déformée dans la grille

Exemple dans la classe *GridCellRenderQuad*

```java
// ----------------------------------------------------------
void compute(Rect rect, Polygon2D quad)
{
  // Copy the quad
  Polygon2D quadCopy = quad.copy(); 
  // Apply scale
  quadCopy.scaleSize(this.scalex, this.scaley);
  // Add to polygons list
  listPolygons.add( quadCopy );
  
  // Stripes ? 
  if (grid.bComputeStripes)
    computeStripes(quadCopy, grid.stripesAngleStrategy, grid.getFieldValue( quadCopy.getCentroid() ) );
}
```


#### GridField
Cette classe permet de fournir une valeur comprise entre 0 et 1 pour être utilisée pour moduler des variables de rendu de grille (espacement et angle de rotation de hachures, mise à l’échelle de motif, etc...)
Voir par exemple la classe *GridCellRenderEllipse* qui utilise cette valeur pour moduler l’espacement des hachures, ainsi que leur orientation.

#### Grid
Cette classe permet de gérer les caractéristiques principales de la grille (résolutions, dimensions, déformations)
Elle maintient une liste d'instances de *GridCellRender* et de *GridField*.

### Outils
* [Processing](www.processing.org) avec les librairies suivantes :
  * [controlP5](http://www.sojamo.de/libraries/controlP5/) par [Andreas Schlegel](http://www.sojamo.de/) 
  * [toxiclibs](http://toxiclibs.org/) par [Karsten Schmidt](http://postspectacular.com/)
* [Axidraw](www.axidraw.com)
* [Inkscape pour Axidraw](https://wiki.evilmadscientist.com/Axidraw_Software_Installation)

### Liens
* [History of computer art part 2 : plotters](https://piratefsh.github.io/2019/01/07/computer-art-history-part-2.html)

### Photos
![Axidraw](images/191123_P5Geneva_poster.JPG)
![Axidraw](images/191123_P5Geneva_concentration.JPG)
![Axidraw](images/191123_P5Geneva_prints_01.jpg)
![Axidraw](images/191123_P5Geneva_prints_02.JPG)


