#Added Bulk Generation Button in Admin Reports.
  Deface::Override.new(:virtual_path => "spree/admin/reports/index",
                       :name => 'printbuttons',
                       :insert_after => "[data-hook='reports_header']",
                       :partial => "spree/admin/orders/print_buttons1"
                       )

#Added Print Invoice to Order show page in Admin.
  Deface::Override.new(:virtual_path  => "spree/layouts/admin",
                       :insert_after => "[data-hook='toolbar']",
                       :partial => "spree/admin/orders/print_buttons",
                       :name => "Invoices"
                       )


#Added Invoice for Users Account.
  Deface::Override.new(:virtual_path => %q{spree/orders/show},
                       :insert_before => "div#order",
                       :name => "invoiceprint",
                       :partial => "spree/admin/orders/print_buttons2"
                      )


#Adding  Language to Spree Admin User Form
   Deface::Override.new(:virtual_path => 'spree/admin/users/_form',
                       :insert_after => "[data-hook='admin_user_form_fields']",
                       :name => 'language',
                       :text => ' <p>
                                      <%= f.label :language, Spree.t(:language) %><br>
                                      <%= f.select :language, [:fr, :nl, :de,:en], {:include_blank => false} %>
                                  </p>'
                        )


##Adding Language to Admin/Users/Show  at Admin interface

  Deface::Override.new(:virtual_path => "spree/admin/users/show",
                       :insert_after => "[data-hook='email']",
                       :name => "languageshowpage",
                       :text => " <td style='text-align:center'> <b> <%= Spree.t('Language') %>:</b></td>
                                  <td> <%= @user.language %> </td>"
                       )

#  Adding Language to Users show page at User Interface.
 Deface::Override.new(:virtual_path => "spree/users/show",
                      :name => "add_language_to_account_summary",
                      :original => '1b7abb3395f278fbd9b8a60ac80519845dd707c9',
                       :insert_after => "dl#user-info",
                      :text =>  "<h3> <b> <%= Spree.t('Language') %>:
                                 <%= @user.language %>  </b> </h3><hr> "
                      )

##Adding Language to Admin/Users/Show  at Admin interface

##########
Deface::Override.new(:virtual_path => %q{spree/checkout/_summary},
                          :name => %q{replace_order_summary'},
                          :replace => %q{[data-hook='order_summary']},
                          :text => %q{<div id="aside" role="aside">
  <div id="order" role="order">

    <h3><%= t(:order_summary) %></h3>

    <table class="items">
      <% for line_item in @order.line_items %>
        <% variant = line_item.variant %>
        <tr>
          <td class="qty">(<%= line_item.quantity %>)</td>
          <td class="description"><%= variant.product.name %></td>
          <td class="price"><%= number_to_currency(line_item.price) %></td>
        </tr>
        <% if Rails.application.railties.all.map(&:railtie_name).include? "spree_flexi_variants" %>
          <%= render :partial => 'spree/shared/additional_line_item_fields', :locals=>{:item => line_item} %>
         <% end %> 
      <% end %>
    </table>

    <table class="total">
      <tr>
        <th>Subtotal</th>
        <td><%= number_to_currency @order.item_total %></td>
      </tr>
      <% @order.adjustments.each do |adjustment| %>
        <tr>
          <th><%= adjustment.label %></th>
          <td class="amount"><%= number_to_currency adjustment.amount -%></td>
        </tr>
      <% end %>
      <tr class="total">
        <th>Total</th>
        <td><%= number_to_currency @order.total %></td>
      </tr>
    </table>

  </div>
</div>})