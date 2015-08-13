module FaqHelper
  def sections
    return [
      {
        :name => "General",
        :id => "gen",
        :questions => [
          {
            :question => "What is Raise Change?",
            :answer_paragraphs => [
              "Raise Change is a platform to raise micro donations for each hour someone volunteers. Volunteers start a cammpaign for their volunteer work and log their hours as they go. Friends, family and strangers can support their volunteer work by pledging to donate a set amount of dollars for every hour volunteered. All donations go to the charity the individual volunteered at or a related organization."
            ]
          },
          {
            :question => "What are the basics?",
            :answer_paragraphs => [
              "Users create <strong>campaigns</strong> to show off their volunteer work and ask for pledges.",
              "As campaign creators <strong>volunteer</strong>, they <strong>log volunteer hours</strong> on their campaign page.",
              "Friends, family and strangers can <strong>support</strong> these campaigns by pledging a small amount of money per hour."
            ]
          },
          {
            :question => "How much do you charge?",
            :answer_paragraphs => [
              "We collect a 5% fee on donations in order to keep the website running and feed ourselves. We also collect a 2.9% + $0.30 processing fees on donations in order to pay the Stripe fees that cover credit card costs. This amount will be deducted from your donation pledge automatically."
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
              "Raise Change is a social enterprise that aligns its business goals with doing good. We want to make volunteering exciting for everyone."
            ]
          },
          {
            :question => "What currency are the donations made in?",
            :answer_paragraphs => [
              "All donations are converted to Canadian dollars. As the website grows, we will include other currencies."
            ]
          }
        ]
      },
      {
        :name => "For volunteers",
        :id => "vol",
        :questions => [
          {
            :question => "How do I get started?",
            :answer_paragraphs => [
              "Before you can start collecting pledges, you will need to start a campaign. Then, simply log into your account and press 'start a camapign' on your front page. Once you create a camaign, you will have a dedicated page that you can share with others. Your campaign page will show you how many supporters are backing you and the amount of donations you are earning per volunteer hour. Everytime you volunteer, log into your account and log these hours in order for the donations to be made."
            ]
          },
          {
            :question => "Why do I need to log my volunteer hours?",
            :answer_paragraphs => [
              "You need to log volunteer hours on your profile in order for us to calculate the donation amounts you will receive at the end of the month."
            ]
          },
          {
            :question => "How often do I need to log my volunteer hours?",
            :answer_paragraphs => [
              "The sooner the better. We calculate the donation amounts at the end of each month, but in order to keep your profile fresh with content, we suggest logging your hours at the end of the day, or at least at the end of the week. Don't forget to upload exciting photos from your volunteering adventures."
            ]
          },
          {
            :question => "Will I get paid to volunteer?",
            :answer_paragraphs => [
              "No. All the money from the donors goes directly to the organization you volunteered at or a related nonprofit."
            ]
          },
          {
            :question => "How does the nonprofit get the money I raised?",
            :answer_paragraphs => [
              "At the end of each month, we will mail the campaign creator (you) a cheque for the amount that was collected from the donors. That way, you can present the cheque to the nonprofit yourself &#x263A"
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