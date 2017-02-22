module OWD
  class OrderUpdate < Document
    def _build opts = {}
      doc.tag!(self.owd_name,
              { clientOrderId:  opts[:order_reference] }) do

        if opts[:bill_to].present?
          bill_opts = opts[:bill_to]
          doc.BILL_NAME             bill_opts[:first_name]      if bill_opts[:first_name]
          doc.BILL_COMPANY          bill_opts[:company_name]    if bill_opts[:company_name]
          doc.BILL_ADDRESS_ONE      bill_opts[:address_one]     if bill_opts[:address_one]
          doc.BILL_ADDRESS_TWO      bill_opts[:address_two]     if bill_opts[:address_two]
          doc.BILL_CITY             bill_opts[:city]            if bill_opts[:city]
          doc.BILL_STATE            bill_opts[:state]           if bill_opts[:state]
          doc.BILL_POSTCODE         bill_opts[:zip]             if bill_opts[:zip]
          doc.BILL_COUNTRY          bill_opts[:country]         if bill_opts[:country]
          doc.BILL_PHONE            bill_opts[:phone]           if bill_opts[:phone]
          doc.BILL_EMAIL            bill_opts[:email]           if bill_opts[:email]
          doc.BILL_PO               bill_opts[:po]              if bill_opts[:po]
        end

        doc.SHIP_NAME             opts[:first_name]      if opts[:first_name]
        doc.SHIP_COMPANY          opts[:company_name]    if opts[:company_name]
        doc.SHIP_ADDRESS_ONE      opts[:address_one]     if opts[:address_one]
        doc.SHIP_ADDRESS_TWO      opts[:address_two]     if opts[:address_two]
        doc.SHIP_CITY             opts[:city]            if opts[:city]
        doc.SHIP_STATE            opts[:state]           if opts[:state]
        doc.SHIP_POSTCODE         opts[:zip]             if opts[:zip]
        doc.SHIP_COUNTRY          opts[:country]         if opts[:country]
        doc.SHIP_PHONE            opts[:phone]           if opts[:phone]
        doc.SHIP_EMAIL            opts[:email]           if opts[:email]
        doc.SHIPPING_METHOD       opts[:shipping_method] if opts[:shipping_method]

        doc.tag!(:LINE_ITEMS) do
          opts[:line_items].each do |line_item|
            doc.LINE_ITEM line_item
          end
        end if opts[:line_items]

      end
    end
  end
end
