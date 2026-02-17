import 'package:flower_app/app/feature/check_out/data/models/credit_card_dto.dart';
import 'package:test/test.dart';

void main() {
  group('CreditCardDTO test cases', () {
    test('fromJson should parse all fields', () {
      final json = {"error": "error1", "message": "message1"};
      final dto = CreditCardDto.fromJson(json);
      expect(dto.error, equals(json["error"]));
      expect(dto.message, equals(json["message"]));
    });
    test("toModel should map relevant fields", () {
      final dto = CreditCardDto(
        error: "error1",
        message: "message1",
        session: Session(id: "id1", url: "url1"),
      );
      final model = dto.toModel();
      expect(model.error, equals(dto.error));
      expect(model.message, equals(dto.message));
      expect(model.url, equals(dto.session?.url));
    });
    test('toJson should serialize all fields', () {
      final dto = CreditCardDto(
        error: "error1",
        message: "message1",
        session: Session(id: "id1", url: "url1"),
      );
      final json = dto.toJson();
      expect(json['error'], equals(dto.error));
      expect(json['message'], equals(dto.message));
      expect(json['session'], equals(dto.session));
    });
  });
  group('Session test cases', () {
    test('fromJson should parse all fields', () {
      final json = {
        "id": "id1",
        "object": "object1",
        "after_expiration": "after_exp1",
        "allow_promotion_codes": true,
        "amount_subtotal": 5,
        "amount_total": 8,
        "billing_address_collection": "collection1",
        "cancel_url": "cancel_url1",
        "client_reference_id": "client_reference_id1",
        "client_secret": "client_secret1",
        "consent": "consent1",
        "consent_collection": "consent_collection1",
        "created": 1,
        "currency": "EGP",
        "currency_conversion": "to USD",
        "custom_fields": [],
        "customer": "customer1",
        "customer_account": "customer_account1",
        "customer_creation": "customer_creation1",
        "customer_email": "customer_email1",
        "discounts": [],
        "expires_at": 5,
        "invoice": "invoice1",
        "livemode": true,
        "locale": "en",
        "mode": "test_mode",
        "origin_context": "origin_context1",
        "payment_intent": "payment_intent1",
        "payment_link": "payment_link1",
        "payment_method_collection": "payment_method_collection1",
        "payment_method_types": ["Paypal", "Visa"],
        "payment_status": "payment_status1",
        "permissions": "permissions1",
        "recovered_from": "recovered_from1",
        "saved_payment_method_options": "saved_payment_method_options1",
        "setup_intent": "setup_intent1",
        "shipping_address_collection": "shipping_address_collection1",
        "shipping_cost": 8000,
        "shipping_details": "shipping_details1",
        "shipping_options": [],
        "status": "status1",
        "submit_type": "submit_type1",
        "subscription": "subscription1",
        "success_url": "success_url1",
        "ui_mode": 'light',
        "url": "url1",
        "wallet_options": "wallet_options1",
      };
      final dto = Session.fromJson(json);
      expect(dto.id, equals(json['id']));
      expect(dto.object, equals(json["object"]));
      expect(dto.afterExpiration, equals(json["after_expiration"]));
      expect(dto.allowPromotionCodes, equals(json["allow_promotion_codes"]));
      expect(dto.amountSubtotal, equals(json["amount_subtotal"]));
      expect(dto.amountTotal, equals(json["amount_total"]));
      expect(
        dto.billingAddressCollection,
        equals(json["billing_address_collection"]),
      );
      expect(dto.cancelUrl, equals(json["cancel_url"]));
      expect(dto.clientReferenceId, equals(json["client_reference_id"]));
      expect(dto.clientSecret, equals(json["client_secret"]));
      expect(dto.consent, equals(json["consent"]));
      expect(dto.consentCollection, equals(json["consent_collection"]));
      expect(dto.created, equals(json["created"]));
      expect(dto.currency, equals(json["currency"]));
      expect(dto.currencyConversion, equals(json["currency_conversion"]));
      expect(dto.customFields, equals(json["custom_fields"]));
      expect(dto.customer, equals(json["customer"]));
      expect(dto.customerAccount, equals(json["customer_account"]));
      expect(dto.customerCreation, equals(json["customer_creation"]));
      expect(dto.customerEmail, equals(json["customer_email"]));
      expect(dto.discounts, equals(json["discounts"]));
      expect(dto.expiresAt, equals(json["expires_at"]));
      expect(dto.invoice, equals(json["invoice"]));
      expect(dto.livemode, equals(json["livemode"]));
      expect(dto.locale, equals(json["locale"]));
      expect(dto.mode, equals(json["mode"]));
      expect(dto.originContext, equals(json["origin_context"]));
      expect(dto.paymentIntent, equals(json["payment_intent"]));
      expect(dto.paymentLink, equals(json["payment_link"]));
      expect(
        dto.paymentMethodCollection,
        equals(json["payment_method_collection"]),
      );
      expect(dto.paymentMethodTypes, equals(json["payment_method_types"]));
      expect(dto.paymentStatus, equals(json["payment_status"]));
      expect(dto.permissions, equals(json["permissions"]));
      expect(dto.recoveredFrom, equals(json["recovered_from"]));
      expect(
        dto.savedPaymentMethodOptions,
        equals(json["saved_payment_method_options"]),
      );
      expect(dto.setupIntent, equals(json["setup_intent"]));
      expect(
        dto.shippingAddressCollection,
        equals(json["shipping_address_collection"]),
      );
      expect(dto.shippingCost, equals(json["shipping_cost"]));
      expect(dto.shippingDetails, equals(json["shipping_details"]));
      expect(dto.shippingOptions, equals(json["shipping_options"]));
      expect(dto.status, equals(json["status"]));
      expect(dto.submitType, equals(json["submit_type"]));
      expect(dto.subscription, equals(json["subscription"]));
      expect(dto.successUrl, equals(json["success_url"]));
      expect(dto.uiMode, equals(json["ui_mode"]));
      expect(dto.url, equals(json["url"]));
      expect(dto.walletOptions, equals(json["wallet_options"]));
    });
    test('toJson should serialize all fields', () {
      final dto = Session(
        id: 'id1',
        adaptivePricing: AdaptivePricing(),
        afterExpiration: "after_exp1",
        allowPromotionCodes: true,
        amountSubtotal: 5,
        amountTotal: 8,
        automaticTax: AutomaticTax(),
        billingAddressCollection: "collection1",
        brandingSettings: BrandingSettings(),
        cancelUrl: "cancel_url1",
        clientReferenceId: "client_reference_id1",
        clientSecret: "client_secret1",
        collectedInformation: CollectedInformation(),
        consent: "consent1",
        consentCollection: "consent_collection1",
        created: 1,
        currency: "EGP",
        currencyConversion: "to USD",
        customFields: [],
        customText: CustomText(),
        customer: "customer1",
        customerAccount: "customer_account1",
        customerCreation: "customer_creation1",
        customerDetails: CustomerDetails(),
        customerEmail: "customer_email1",
        discounts: [],
        expiresAt: 5,
        invoice: "invoice1",
        invoiceCreation: InvoiceCreation(),
        livemode: true,
        locale: "en",
        metadata: SessionMetadata(),
        mode: "test_mode",
        object: "object1",
        originContext: "origin_context1",
        paymentIntent: "payment_intent1",
        paymentLink: "payment_link1",
        paymentMethodCollection: "payment_method_collection1",
        paymentMethodConfigurationDetails: PaymentMethodConfigurationDetails(),
        paymentMethodOptions: PaymentMethodOptions(),
        paymentMethodTypes: ["Paypal", "Visa"],
        paymentStatus: "payment_status1",
        permissions: "permissions1",
        phoneNumberCollection: AdaptivePricing(),
        recoveredFrom: "recovered_from1",
        savedPaymentMethodOptions: "saved_payment_method_options1",
        setupIntent: "setup_intent1",
        shippingAddressCollection: "shipping_address_collection1",
        shippingCost: 8000,
        shippingDetails: "shipping_details1",
        shippingOptions: [],
        status: 'status1',
        submitType: "submit_type1",
        subscription: "subscription1",
        successUrl: "success_url1",
        totalDetails: TotalDetails(),
        uiMode: "light",
        url: "url1",
        walletOptions: "wallet_options1",
      );
      final json = dto.toJson();
      expect(json['adaptive_pricing'], equals(dto.adaptivePricing));
      expect(json["automatic_tax"], equals(dto.automaticTax));
      expect(json["branding_settings"], equals(dto.brandingSettings));
      expect(json["collected_information"], equals(dto.collectedInformation));
      expect(json["custom_text"], equals(dto.customText));
      expect(json["customer_details"], equals(dto.customerDetails));
      expect(json["invoice_creation"], equals(dto.invoiceCreation));
      expect(json["metadata"], equals(dto.metadata));
      expect(
        json["payment_method_configuration_details"],
        equals(dto.paymentMethodConfigurationDetails),
      );
      expect(json["payment_method_options"], equals(dto.paymentMethodOptions));
      expect(
        json["phone_number_collection"],
        equals(dto.phoneNumberCollection),
      );
      expect(json["total_details"], equals(dto.totalDetails));
      expect(json["id"], equals(dto.id));
      expect(json["object"], equals(dto.object));
      expect(json["after_expiration"], equals(dto.afterExpiration));
      expect(json["allow_promotion_codes"], equals(dto.allowPromotionCodes));
      expect(json["amount_subtotal"], equals(dto.amountSubtotal));
      expect(json["amount_total"], equals(dto.amountTotal));
      expect(
        json["billing_address_collection"],
        equals(dto.billingAddressCollection),
      );
      expect(json["cancel_url"], equals(dto.cancelUrl));
      expect(json["client_reference_id"], equals(dto.clientReferenceId));
      expect(json["client_secret"], equals(dto.clientSecret));
      expect(json["consent"], equals(dto.consent));
      expect(json["consent_collection"], equals(dto.consentCollection));
      expect(json["created"], equals(dto.created));
      expect(json["currency"], equals(dto.currency));
      expect(json["currency_conversion"], equals(dto.currencyConversion));
      expect(json["custom_fields"], equals(dto.customFields));
      expect(json["customer"], equals(dto.customer));
      expect(json["customer_account"], equals(dto.customerAccount));
      expect(json["customer_creation"], equals(dto.customerCreation));
      expect(json["customer_email"], equals(dto.customerEmail));
      expect(json["discounts"], equals(dto.discounts));
      expect(json["expires_at"], equals(dto.expiresAt));
      expect(json["invoice"], equals(dto.invoice));
      expect(json["livemode"], equals(dto.livemode));
      expect(json["locale"], equals(dto.locale));
      expect(json["mode"], equals(dto.mode));
      expect(json["origin_context"], equals(dto.originContext));
      expect(json["payment_intent"], equals(dto.paymentIntent));
      expect(json["payment_link"], equals(dto.paymentLink));
      expect(
        json["payment_method_collection"],
        equals(dto.paymentMethodCollection),
      );
      expect(json["payment_method_types"], equals(dto.paymentMethodTypes));
      expect(json["payment_status"], equals(dto.paymentStatus));
      expect(json["permissions"], equals(dto.permissions));
      expect(json["recovered_from"], equals(dto.recoveredFrom));
      expect(
        json["saved_payment_method_options"],
        equals(dto.savedPaymentMethodOptions),
      );
      expect(json["setup_intent"], equals(dto.setupIntent));
      expect(
        json["shipping_address_collection"],
        equals(dto.shippingAddressCollection),
      );
      expect(json["shipping_cost"], equals(dto.shippingCost));
      expect(json["shipping_details"], equals(dto.shippingDetails));
      expect(json["shipping_options"], equals(dto.shippingOptions));
      expect(json["status"], equals(dto.status));
      expect(json["submit_type"], equals(dto.submitType));
      expect(json["subscription"], equals(dto.subscription));
      expect(json["success_url"], equals(dto.successUrl));
      expect(json["ui_mode"], equals(dto.uiMode));
      expect(json["url"], equals(dto.url));
      expect(json["wallet_options"], equals(dto.walletOptions));
    });
  });
  group('AdaptivePricing test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "enabled":true
      };
      final dto=AdaptivePricing.fromJson(json);
      expect(dto.enabled, equals(json["enabled"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=AdaptivePricing(
        enabled: true
      );
      final json=dto.toJson();
      expect(json["enabled"], equals(dto.enabled));
    },);
  },);
  group('AutomaticTax test cases',(){
    test('fromJson should parse all fields', () {
      final json={
        "enabled":true,
        "liability":"liability1",
        "provider":"provider1",
        "status":"status1"
      };
      final dto=AutomaticTax.fromJson(json);
      expect(dto.enabled, equals(json["enabled"]));
      expect(dto.liability, equals(json["liability"]));
      expect(dto.provider, equals(json["provider"]));
      expect(dto.status, equals(json["status"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=AutomaticTax(
        enabled: true,
        liability: "liability1",
        provider: "provider1",
        status: "status1"
      );
      final json=dto.toJson();
      expect(json["enabled"], equals(dto.enabled));
      expect(json["liability"], equals(dto.liability));
      expect(json["provider"], equals(dto.provider));
      expect(json["status"], equals(dto.status));
    },);
  });
  group('BrandingSettings test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "background_color":"blue",
        "border_style":"italic",
        "button_color":"red",
        "display_name":"display_name1",
        "font_family":"Roboto",
      };
      final dto=BrandingSettings.fromJson(json);
      expect(dto.backgroundColor, equals(json["background_color"]));
      expect(dto.borderStyle, equals(json["border_style"]));
      expect(dto.buttonColor, equals(json["button_color"]));
      expect(dto.displayName, equals(json["display_name"]));
      expect(dto.fontFamily, equals(json["font_family"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=BrandingSettings(
        backgroundColor: "blue",
        borderStyle: "italic",
        buttonColor: "red",
        displayName: "display_name1",
        fontFamily: "Roboto",
        icon: Icon(),
        logo: Icon()
      );
      final json=dto.toJson();
      expect(json["background_color"], equals(dto.backgroundColor));
      expect(json["border_style"], equals(dto.borderStyle));
      expect(json["button_color"], equals(dto.buttonColor));
      expect(json["display_name"], equals(dto.displayName));
      expect(json["font_family"], equals(dto.fontFamily));
      expect(json["icon"], equals(dto.icon));
      expect(json["logo"], equals(dto.logo));
    },);
  },);
  group('Icon test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "file":"file1",
        "type":"type1"
      };
      final dto=Icon.fromJson(json);
      expect(dto.file, equals(json['file']));
      expect(dto.type, equals(json['type']));
    },);
    test('toJson should serialize all fields', () {
      final dto=Icon(
        file: "file1",
        type: "type1"
      );
      final json=dto.toJson();
      expect(json['file'], equals(dto.file));
      expect(json['type'], equals(dto.type));
    },);
  },);
  group('CollectedInformation test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "business_name":"business_name1",
        "individual_name":"individual_name1",
        "shipping_details":"shipping_details1"
      };
      final dto=CollectedInformation.fromJson(json);
      expect(dto.businessName, equals(json["business_name"]));
      expect(dto.individualName, equals(json["individual_name"]));
      expect(dto.shippingDetails, equals(json["shipping_details"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=CollectedInformation(
        businessName: "business_name1",
        individualName: "individual_name1",
        shippingDetails: "shipping_details1"
      );
      final json=dto.toJson();
      expect(json["business_name"], equals(dto.businessName));
      expect(json["individual_name"], equals(dto.individualName));
      expect(json["shipping_details"], equals(dto.shippingDetails));
    },);
  },);
  group('CustomText test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "after_submit":"after_submit1",
        "shipping_address":"shipping_address1",
        "submit":"submit1",
        "terms_of_service_acceptance":"terms_of_service_acceptance1"
      };
      final dto=CustomText.fromJson(json);
      expect(dto.afterSubmit, equals(json["after_submit"]));
      expect(dto.shippingAddress, equals(json["shipping_address"]));
      expect(dto.submit, equals(json["submit"]));
      expect(dto.termsOfServiceAcceptance, json["terms_of_service_acceptance"]);
    },);
    test('toJson should serialize all fields', () {
      final dto=CustomText(
        afterSubmit: "after_submit1",
        shippingAddress: "shipping_address1",
        submit: "submit1",
        termsOfServiceAcceptance: "terms_of_service_acceptance1"
      );
      final json=dto.toJson();
      expect(json["after_submit"], equals(dto.afterSubmit));
      expect(json["shipping_address"], equals(dto.shippingAddress));
      expect(json["submit"], equals(dto.submit));
      expect(json["terms_of_service_acceptance"], equals(dto.termsOfServiceAcceptance));
    },);
  },);
  group('CustomerDetails test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "address":"address1",
        "business_name":"business_name1",
        "email":"email1",
        "individual_name":"individual_name1",
        "name":"name1",
        "phone":"phone1",
        "tax_exempt":"tax_exempt1",
        "tax_ids":"tax_ids1"
      };
      final dto=CustomerDetails.fromJson(json);
      expect(dto.address, equals(json["address"]));
      expect(dto.businessName, equals(json["business_name"]));
      expect(dto.email, equals(json["email"]));
      expect(dto.individualName, equals(json["individual_name"]));
      expect(dto.name, equals(json["name"]));
      expect(dto.phone, equals(json["phone"]));
      expect(dto.taxExempt, equals(json["tax_exempt"]));
      expect(dto.taxIds, equals(json["tax_ids"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=CustomerDetails(
        address:"address1",
        businessName:"business_name1",
        email:"email1",
        individualName:"individual_name1",
        name: "name1",
        phone: "phone1",
        taxExempt: "tax_exempt1",
        taxIds: "tax_ids1"
      );
      final json=dto.toJson();
      expect(json["address"], equals(dto.address));
      expect(json["business_name"], equals(dto.businessName));
      expect(json["email"], equals(dto.email));
      expect(json["individual_name"], dto.individualName);
      expect(json["name"], equals(dto.name));
      expect(json["phone"], equals(dto.phone));
      expect(json["tax_exempt"], equals(dto.taxExempt));
      expect(json["tax_ids"], equals(dto.taxIds));
    },);
  },);
  group('InvoiceCreation test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "enabled":true
      };
      final dto=InvoiceCreation.fromJson(json);
      expect(dto.enabled, equals(json["enabled"]));
    },);
    test("toJson should serialize all fields", () {
      final dto=InvoiceCreation(
        enabled: true,
        invoiceData: InvoiceData()
      );
      final json=dto.toJson();
      expect(json["enabled"], equals(dto.enabled));
      expect(json["invoice_data"], equals(dto.invoiceData));
    },);
  },);
  group('InvoiceData test cases', () {
    test('fromJson should parse all elements', () {
      final json={
        "account_tax_ids":"account_tax_ids1",
        "custom_fields":"custom_fields1",
        "description":"description1",
        "footer":"footer1",
        "issuer":"issuer1",
        "rendering_options":"rendering_options1"
      };
      final dto=InvoiceData.fromJson(json);
      expect(dto.accountTaxIds, equals(json["account_tax_ids"]));
      expect(dto.customFields, equals(json["custom_fields"]));
      expect(dto.description, equals(json["description"]));
      expect(dto.footer, equals(json["footer"]));
      expect(dto.issuer, equals(json["issuer"]));
      expect(dto.renderingOptions, equals(json["rendering_options"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=InvoiceData(
        accountTaxIds: "account_tax_ids1",
        customFields: "custom_fields1",
        description: "description1",
        footer: "footer1",
        issuer: "issuer1",
        metadata: InvoiceDataMetadata(),
        renderingOptions: "rendering_options1"
      );
      final json=dto.toJson();
      expect(json["account_tax_ids"], equals(dto.accountTaxIds));
      expect(json["custom_fields"], equals(dto.customFields));
      expect(json["description"], equals(dto.description));
      expect(json["footer"], equals(dto.footer));
      expect(json["issuer"], equals(dto.issuer));
      expect(json["metadata"], equals(dto.metadata));
      expect(json["rendering_options"], equals(dto.renderingOptions));
    },);
  },);
  group("SessionMetadata test cases", () {
    test("fromJson should parse all fields", () {
      final json={
        "city":"city1",
        "lat":"lat1",
        "long":"long1",
        "phone":"phone1",
        "street":"street1"
      };
      final dto=SessionMetadata.fromJson(json);
      expect(dto.city, equals(json['city']));
      expect(dto.lat, equals(json['lat']));
      expect(dto.long, equals(json['long']));
      expect(dto.phone, equals(json['phone']));
      expect(dto.street, equals(json['street']));
    },);
    test('toJson should serialize all fields', () {
      final dto=SessionMetadata(
        city: "city1",
        lat: "lat1",
        long: "long1",
        phone: "phone1",
        street: "street1"
      );
      final json=dto.toJson();
      expect(json['city'], equals(dto.city));
      expect(json['lat'], equals(dto.lat));
      expect(json['long'], equals(dto.long));
      expect(json['phone'], equals(dto.phone));
      expect(json['street'], equals(dto.street));
    },);
  },);
  group('PaymentMethodConfigurationDetails test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "id":"id1",
        "parent":"parent1"
      };
      final dto=PaymentMethodConfigurationDetails.fromJson(json);
      expect(dto.id, equals(json['id']));
      expect(dto.parent, equals(json['parent']));
    },);
    test('toJson should serialize all fields', () {
      final dto=PaymentMethodConfigurationDetails(
        id: "id1",
        parent: "parent1"
      );
      final json=dto.toJson();
      expect(json['id'], equals(dto.id));
      expect(json['parent'], equals(dto.parent));
    },);
  },);
  group('PaymentMethodOptions test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "card":{"request_three_d_secure":"optional"}
      };
      final dto=PaymentMethodOptions.fromJson(json);
      expect(dto.card?.requestThreeDSecure, equals(json['card']!["request_three_d_secure"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=PaymentMethodOptions(
        card: Card()
      );
      final json=dto.toJson();
      expect(json['card'], equals(dto.card));
    },);
  },);
  group('Card test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "request_three_d_secure":"optional"
      };
      final dto=Card.fromJson(json);
      expect(dto.requestThreeDSecure, equals(json["request_three_d_secure"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=Card(
        requestThreeDSecure: "optional"
      );
      final json=dto.toJson();
      expect(json["request_three_d_secure"], equals(dto.requestThreeDSecure));
    },);
  },);
  group('TotalDetails test cases', () {
    test('fromJson should parse all fields', () {
      final json={
        "amount_discount":20,
        "amount_shipping":30,
        "amount_tax":50
      };
      final dto=TotalDetails.fromJson(json);
      expect(dto.amountDiscount, equals(json["amount_discount"]));
      expect(dto.amountShipping, equals(json["amount_shipping"]));
      expect(dto.amountTax, equals(json["amount_tax"]));
    },);
    test('toJson should serialize all fields', () {
      final dto=TotalDetails(
        amountDiscount: 20,
        amountShipping: 30,
        amountTax: 50
      );
      final json=dto.toJson();
      expect(json["amount_discount"], equals(dto.amountDiscount));
      expect(json["amount_shipping"], equals(dto.amountShipping));
      expect(json["amount_tax"], equals(dto.amountTax));
    },);
  },);
}
