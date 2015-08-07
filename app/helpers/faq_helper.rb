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
              "We collect a 5% fee on donations in order to keep the website running and feed ourselves. We also collect a 2.9% + $0.30 processing fees on donations in order to pay the stripe fees that cover credit card costs."
            ]
          },
          {
            :question => "What about the sites that claim not to charge anything?",
            :answer_paragraphs => [
              "No site runs for free. Most crowdsourcing websites charge between 5-10% plus processing fees. However, some websites claim not to charge anything, which is a bit misleading. They still charge the same processing fees and run “on donations”, which are actually automatically added on to your donation and have to be opted out via multiple steps during the donation process."
            ]
          }
        ]
      },
      {
        :name => "For volunteers",
        :id => "vol",
        :questions => [
          {
            :question => "How does the nonprofit get the money I raised?",
            :answer_paragraphs => [
              "At the end of the #{donation_period}, we will mail the campaign creator (you) a cheque for the amount that was collected from the donors. That way, you can present the cheque it to the nonprofit yourself :)"
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
              "Donations are charged #{donation_period}."
            ]
          },
          {
            :question => "Will I get a tax receipt for my donation?",
            :answer_paragraphs => [
              "You will only get a donation receipt when donating to a volunteer connected with a certified Raise Change charity. Those will be indicated with a CERTIFIED tag on the campaign. If you don’t see the tag, you will not be receiving a tax receipt."
            ]
          },
          {
            :question => "Can I cancel my donation pledge?",
            :answer_paragraphs => [
              "Yes. If you change your mind at any point, you can simply log into your account and cancel your pledge (but your mom would be disappointed in you)."
            ]
          }
        ]
      }
    ]
  end
end