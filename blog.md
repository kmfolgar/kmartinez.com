---
layout: default
---

<div class="posts">
  
  <ul>
    {% for post in site.posts %}
      <li>
        {{ post.date | date: site.theme_config.date_format }} <a href="{{ post.url | relative_url }}">{{ post.title | downcase }}</a>
      </li>
    {% endfor %}
    
  </ul>

  {% for post in site.posts %}
    <article class="post">

      <h1><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h1>

      <div class="entry">
        {{ post.excerpt }}
      </div>

      <a href="{{ site.baseurl }}{{ post.url }}" class="read-more">Read More</a>
    </article>
  {% endfor %}
  
</div>