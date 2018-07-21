new.html.erb
<%= form_for @user do |f| %>
  <%= f.label :name, "Name:" %> </br>
  <%= f.text_field :name, placeholder: "Required" %></br>

  <%= f.label :dci_number, "DCI Number:"%> </br>
  <%= f.number_field :dci_number, placeholder: "Optional" %> </br>

  <%= f.label :password, "Password:" %> </br>
  <%= f.password_field :password, placeholder: "Required" %> </br>

  </br>

  <%= f.submit "Create User" %>
<% end %>

users_controller:
class UsersController < ApplicationController
  def index

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    return redirect_to controller: 'users', action: 'new' unless @user.save
    session[:user_id] = @user.id
    redirect_to user_path(@user)
  end

  def show
    if logged_in?
      @user = User.find_by(id: params[:id])
    else
      redirect_to root_url
    end
  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :tickets, :admin, :nausea, :happiness, :height)
  end
end

user.rb:
class User < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  has_many :decks, dependent: :destroy
  has_many :magic_cards, dependent: :destroy
  has_secure_password
end

Migration:
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :dci_number
      t.timestamps
    end
  end
end

Show.html.erb:
<form method="get" action="/logout">
  <input type="submit" value="Logout" style="float: right;">
</form>

<fieldset>
  <legend><h2><%=@user.name.titlecase%>: </h2></legend>

  <fieldset>
    <%= form_tag(new_deck_path, method: "get") do %>
      <h4 style="display: inline-block">Decks: <%= submit_tag("Create New Deck") %></h4></br>
    <% end %>

    <%@user.decks.each do |deck| %>
      <%= link_to deck.name, deck_path(deck)%> </br>
    <%end %>
  </fieldset>

  </br></br>

  <fieldset>
    <%= form_tag(new_card_path, method: "get") do %>
      <h4 style="display: inline-block">Cards: <%= submit_tag("Create New Card") %></h4></br>
    <% end %>

    <%@user.cards.each do |card| %>
      <%= link_to card.name, card_path(card)%> </br>
    <%end %>
  </fieldset>
</fieldset>
