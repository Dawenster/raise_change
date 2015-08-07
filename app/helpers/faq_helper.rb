module FaqHelper
  def sections
    return [
      {
        :name => "General",
        :id => "gen",
        :questions => [
          {
            :question => "How much do you charge?",
            :answer_paragraphs => [
              "We collect a 5% fee on donations in order to keep the website running and feed ourselves. We also collect a 2.9% + $0.30 processing fees on donations in order to pay the stripe fees that cover credit card costs. This amount will be deducted from your donation pledge automatically."
            ]
          },
          {
            :question => "What about the sites that claim not to charge a fee?",
            :answer_paragraphs => [
              "No site runs for free. Most crowdsourcing websites charge between 5-10% plus processing fees. However, some websites claim not to charge anything, which is a bit misleading. They still charge the same processing fees and run “on donations”, which are actually automatically added on to your donation and have to be opted out via multiple steps during the donation process."
            ]
          },
          {
            :question => "Are you a not-for-profit?",
            :answer_paragraphs => [
              "Raise Change is a social enterprise that aligns its business goals with doing good."
            ]
          }
        ]
      },
      {
        :name => "For volunteers",
        :id => "vol",
        :questions => [
          {
            :question => "Will I get paid to volunteer?",
            :answer_paragraphs => [
              "No. All the money from the donors goes directly to the organization you volunteered at or a related nonprofit"
            ]
          },
          {
            :question => "How does the nonprofit get the money I raised?",
            :answer_paragraphs => [
              "At the end of each month, we will mail the campaign creator (you) a cheque for the amount that was collected from the donors. That way, you can present the cheque to the nonprofit yourself :)"
            ]
          },
          {
            :question => "I don't have time to volunteer, what should I do?",
            :answer_paragraphs => [
              "How did it get so late so soon? It's night before it's afternoon. December is here before it's June. My goodness how the time has flewn. How did it get so late so soon? - Dr. Seuss",
              "Time flies, even for the best of us. If you really can't find time to volunteer, you can always back other people's campaigns!"
            ]
          }
        ]
      },
      {
        :name => "For supporters",
        :id => "sup",
        :questions => [
          {
            :question => "When do you charge my credit card?",
            :answer_paragraphs => [
              "Donations are charged at the end of each month."
            ]
          },
          {
            :question => "Can I set the maximum donation amount?",
            :answer_paragraphs => [
              "Yes. During the donation process, you can set a maximum amount you are willing to donate per month. Once the volunteer reaches that amount, you will no longer be charged during that month. When you no longer want to pledge your support, simply cancel your pledge and you won't be charged from that point."
            ]
          },
          {
            :question => "Will I get a tax receipt for my donation?",
            :answer_paragraphs => [
              "You will only get a donation receipt when donating to a volunteer connected with a certified Raise Change charity. Those will be indicated with a CERTIFIED tag on the campaign. If you don’t see the tag, you will not be receiving a tax receipt."
            ]
          },
          {
            :question => "Is my credit card information safe?",
            :answer_paragraphs => [
              "Yes, all credit card information is encrypted. We use Stripe to process all payments, which is one of the biggest credit card payment companies. Other companies that use Stripe include Twitter, Kickstarter and Salesforce.com."
            ]
          },
          {
            :question => "Can I cancel my donation pledge?",
            :answer_paragraphs => [
              "Yes. If you change your mind at any point, you can simply log into your account and cancel your pledge (but your mom will be disappointed in you)."
            ]
          }

        ]
      }
    ]
  end
end