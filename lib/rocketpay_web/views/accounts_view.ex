defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transactions.Response, as: TransactionResponse

  def render("update.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Ballanced updated successfully",
      account: %{
        id: id,
        balance: balance
      }
    }
  end

  def render("transaction.json",
              %{transaction: %TransactionResponse
                {
                  to_account:
                    %Account{
                      id: sender_id,
                      balance: sender_balance
                    },
                  from_account:
                    %Account{
                      id: receiver_id,
                      balance: receiver_balance
                    },
                }
              }
            ) do
    %{
      message: "Transaction done successfully",
      transaction: %{
        from_account: %{
          id: sender_id,
          balance: sender_balance
        },
        to_account: %{
          id: receiver_id,
          balance: receiver_balance
        }
      }
    }
  end
end
