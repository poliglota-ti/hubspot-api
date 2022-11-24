module Hubspot
  URLS =  {
            base_v4: 'https://api.hubapi.com/crm/v4/objects/',
            base_v3: 'https://api.hubapi.com/crm/v3/objects/',
            search_contact: 'contacts/search',
            contact: 'contacts',
            deals: 'deals',
            association_contact_deal: 'contacts/contactId/associations/toObjectType/toObjectId/contact_to_deal'
          }.freeze
end