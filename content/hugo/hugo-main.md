---
title: Hugo
description: Information about Hugo, the static site generator (SSG)
---

## Getting Started

```hugo new site <site-name>```

```cd <site-name>```

Set site wide settings in `config.toml`, such as theme. 

Content should contain markdown files. 
Themes will contain your theme. 
Static will contain non-webpage files (e.g. images, style.css, documents etc). 

``hugo``` - command builds site. You can then upload the directory `Public` which will have the generated html.

```hugo serve``` - host website on ```localhost:1313```

should use
```hugo server --noHTTPCache``` - to avoid caching so we can see when changes are made in the preview. 

```hugo new <new-content>.md```
Creates a markdown file in your content directory. Based on the archetype  'default'. 

### Links

**Local Links**

```[link text](/filename#heading)```
e.g. Click for [Hugo variables](#hugo-variables)

NOTE: You have to strip out the capitals (lowercase only) in the heading section otherwise the links don't work. 

**URL Links**

A [link](http://example.com "Title").

### Images

```![my image](/images/pic.jpeg)``` - don't need to specify `/static`

### Adding content

Add content to any index file generated automatically by creating a file ```_index.md```. 

In subdirectories, e.g. ```/content/blog```, include ```_index.md``` to add extra content to list. 

### Default pages

When you have a theme, your website looks at the theme for the default files. If you create a file in the website directory it will overwrite the file, otherwise it will just look at what the theme is doing. 

**Layouts***
list file - template for index files
single file - template for regular content pages

### Hugo variables

Pages variables - .Content, .Title, etc. 

.range - kind of like a ```for loop```. Loops through all pages in directory and generates a list entry. 

.Summary - a generated summary of content e.g {{.Summary}}. Truncates first potion of content from page. 

### Customise main page

Go into single and copy it to main layouts file. 
Rename to index.html. 

### Previous and next

```/layouts/partials```

Tweak to remove most stuff from home e.g. if not .IsHome 

.Next