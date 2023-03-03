# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


CODE GRAVEYARD 

FOLLOWERS COUNT WAS IN INDEX.HTML.ERB
<% if user_signed_in? %>
    <%# if current_user.admin %>
      <!-- <h4 style="color: green" > You are an Admin </h4> -->
    <%# end %>

    <!-- FOLLOWERS COUNT  -->

    <% current_user.follow_requests.each do |request| %>
      <%= request.followerable.email %> Wants to follow you 
      <%= button_to "Accept", accept_path(request.followerable) %>
      <%= button_to "Decline", decline_path(request.followerable) %>
    <% end %>

    Followers
    <% current_user.followers.each do |follower| %>
      <p> <b> <%= link_to follower.email, follower %> </b> </p>
    <% end %>

    Following
    <% current_user.following.each do |following| %>
      <p> <%= link_to following.email, following %> </p>
    <% end %>
  <% end %>


USER IMAGE
  <% if current_user && current_user.avatar.attached? %>
            <%= image_tag current_user.avatar, style:"width:50px; height: 50px;" %>
      <% end  %>

search for navbar
<li class="nav-item">
    <%= form_with url: profiles_index_path, method: :get, class: "d-flex" do |form|  %>
      <%= form.search_field :query, value: params[:query], placeholder: "Search", class: "form-control me-1"  %>
      <%= form.submit "Search", class: "btn btn-outline-primary" %>
    <% end  %>
  </li>