{extends file='page.tpl'}

{block name='page_title'}
  {l s='Order confirmation' d='Shop.Theme.Checkout'}
{/block}

{block name='page_content_container' prepend}
  <section id="content-hook_payment_return">
    {$HOOK_PAYMENT_RETURN nofilter}
  </section>

  <section id="content-hook_order_confirmation">
    <h3>{l s='Your order is confirmed' d='Shop.Theme.Checkout'}</h3>
    <p>
      {l s='An email has been sent to your mail address %email%.' sprintf=['%email%' => $customer.email] d='Shop.Theme.Checkout'}
      {if $order.details.invoice_url}
        {* [1][/1] is for a HTML tag. *}
        {l
          s='You can also [1]download your invoice[/1]'
          sprintf=[
            '[1]' => "<a href='{$order.details.invoice_url}'>",
            '[/1]' => "</a>"
          ]
          d='Shop.Theme.Checkout'
        }
      {/if}
    </p>
    {$HOOK_ORDER_CONFIRMATION nofilter}
  </section>
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation">

    {block name='order_confirmation_table'}
      {include
        file='checkout/_partials/order-confirmation-table.tpl'
        products=$order.products
        subtotals=$order.subtotals
        totals=$order.totals
        labels=$order.labels
      }
    {/block}

    <div id='order-details'>
        <h3>{l s='Order details' d='Shop.Theme.Checkout'}</h3>
        <ul>
          <li>{l s='Order reference %reference%' sprintf=['%reference' => $order.details.reference] d='Shop.Theme.Checkout'}</li>
          <li>{l s='Payment method %method_name%' sprintf=['%method_name%' => $order.details.payment] d='Shop.Theme.Checkout'}</li>
          {if !$order.details.is_virtual}
            <li>{l s='Shipping method %method_name%' sprintf=['%method_name%' => $order.carrier.name] d='Shop.Theme.Checkout'}</li>
          {/if}
        </ul>
    </div>

    {if $customer.is_guest}
    <div id='registration-form'>
        <h4>{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</h4>
        {render file='customer/_partials/customer-form.tpl' ui=$register_form}
    </div>
    {/if}

    {hook h='displayOrderConfirmation1'}
  </section>
{/block}

{block name='page_content_container' append}
  <section id="content-hook-order-confirmation-footer">
    {hook h='displayOrderConfirmation2'}
  </section>
{/block}
