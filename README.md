# vernissage.rb

A web gallery processor for a digital portfolio, custom made for
http://plamenmadjarovart.com.

## Details

Vernissage assumes two sets of image files, called originals and thumbnails,
that are placed under different directories. Here's an example directory tree
processed by `vernissage.rb`:

    .
    |
    + Works
    |
    +-- Paradise Lost
    |
    +---- Belshazzar's Feast.jpg
    |
    +---- Satan Presiding at the Infernal Council.png
    |
    +---- The Temptation and Fall of Eve.JPG
    |
    + Thumbnails
    |
    +-- Paradise Lost
    |
    +---- Belshazzar's.jpg
    |
    +---- Satan at the Infernal Council.png
    |
    +---- Eve.jpg

Here the originals are placed under `Works` and the thumbnails, well, under
`Thumbnails`. The level under those classifies the images in *galleries*. In
the above case we have a single gallery called "Paradise Lost". Vernissage
compiles the galleries from the originals directory and looks for their pairs
in the thumbnails directory. It then displays the collection of works on a
single page, defined by a template.

## Code Walkthrough

Vernissage tries to be explicit with class names, but here are some starting
points:

 - `Vernissage::Finissage` is exposes the compiled galleries to the site
   template.
 - `Vernissage::Discovery` deals with the directory-level matching of the
   images. It gerates `Curation`s which pair originals with their thumbnails.
 - `Vernissage::Curator` implements the image similarity logic.

## Runtime Dependencies

 - [HAML](http://haml.info/): provides the templating engine for the site
   generation.

## Development Dependencies

 - [FakeFS](https://github.com/defunkt/fakefs): makes filesystem tests possible.
 - [YARD](http://yardoc.org/): for code documentation.

## License

(The MIT License)

Copyright © 2014 Kiril Tonev

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
