defmodule HelloWeb.SimpleFormLetBindingLive do
  use HelloWeb, :live_view

  defmodule FormSchema do
    use Ecto.Schema
    import Ecto.Changeset

    @primary_key false
    embedded_schema do
      field(:foo, :string)
      field(:bar, :string)
    end

    def changeset(data, attrs) do
      data
      |> cast(attrs, [:foo, :bar])
      |> validate_required([:foo, :bar])
    end
  end

  @impl Phoenix.LiveView
  def handle_params(_, _, socket) do
    form = to_form(FormSchema.changeset(%FormSchema{}, %{}))
    socket = assign(socket, form: form)
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <.simple_form :let={f} for={@form}>
      <table>
        <tr>
          <th><code>@form.name</code></th>
          <td><code><%= inspect(@form.name) %></code></td>
        </tr>
        <tr>
          <th><code>f.name</code></th>
          <td><code><%= inspect(f.name) %></code></td>
        </tr>
      </table>

      <.input field={@form[:foo]} label="Foo" />
      <.input field={f[:bar]} label="Bar" />
    </.simple_form>
    """
  end
end
