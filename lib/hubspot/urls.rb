module Hubspot
  URLS =  {
            base_v4: 'https://api.hubapi.com/crm/v4/',
            base_v3: 'https://api.hubapi.com/crm/v3/',
            search_contact: 'objects/contacts/search',
            contact: 'objects/contacts',
            deals: 'objects/deals',
            association_contact_deal: 'objects/contacts/contactId/associations/toObjectType/toObjectId/contact_to_deal',
            association_deal_contact:'objects/deals/dealId/associations/toObjectType',
            properties: 'properties/objectType/propertyName',
            property:'properties/Deal',
            owners:'owners'
          }.freeze
end