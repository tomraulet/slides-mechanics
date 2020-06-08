# TR Slides repository

## About

This my slides repository.
They are written in Markdown and generated with [pandoc](https://pandoc.org/) and [revealjs (v3.9.2)](https://github.com/hakimel/reveal.js)

## How to generate slides

* Install dependencies
  * [pandoc](#pandoc-install)
  * [revealjs](#revealjs-install)
  * [rsync](#rsync-install)

* Slides files have to be named `slides.md` and placed in `slideshow` directory, no matter subdirectories.

Then

```bash
./generate_slides.sh
```

Finally, open generated `index.html` with your internet browser.

## Tips

### Generate PPTX

```bash
find slideshow/* -name 'slides.md' -exec sh -c 'pandoc {} -o $(dirname {})/slides.pptx  2> /dev/null' \;
```

### Vertical slides

Inside a markdown slide `---`, wrap your markdown content as this :

```markdown
--- <!-- horizontal slide separator -->
<section> <!-- vertical slide opening markup -->
<h4>Subtitle</h4>
Here is my content
work in markdown

* item1

![broken image link](no_img.png)

[link to google](http://google.com)
</section> <!-- vertical slide closing markup -->

<section> <!-- vertical slide opening markup -->
another content here
</section> <!-- vertical slide closing markup -->

```

You'll have 2 vertical slides in your presentation with the snippet above.

### Customize revealjs option

Via pandoc we can add revealjs configuration option. Juste create a `revealjs_option.txt` with custom option inside, in directory containing `slides.md`

```bash
#for getting Innolea style slides
-V slideNumber=true -V theme=white
# or alternative
-V theme=black
```

See [this page](https://github.com/hakimel/reveal.js#configuration) for more information

### Iframe fullscreen background

```markdown
---
<section data-background-iframe="http://google.fr" data-background-interactive>
</section>
---
```

## Dependencies installation

### Pandoc install

[Pandoc installation doc](https://pandoc.org/installing.html)

### Revealjs install

At root directory

```bash
# for 3.9.2 release
wget https://github.com/hakimel/reveal.js/archive/3.9.2.zip
unzip 3.9.2.zip
mv reveal.js-3.9.2 reveal.js
rm 3.9.2.zip
```

### rsync install

If not installed, on CentOS

```bash
sudo yum install rsync
```
