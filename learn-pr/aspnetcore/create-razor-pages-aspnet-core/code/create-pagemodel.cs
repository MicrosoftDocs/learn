@page "{productId:int?}"
@model ContosoPets.Ui.Pages.Products.IndexModel
@{
    ViewData["Title"] = "Admin Index";
}

<h1>Product Administration</h1>

<table class="table table-striped">
    <thead>
        <tr>
            <th scope="col">Product</th>
            <th scope="col">Price</th>
            <th scope="col"></th>
        </tr>
    </thead>
    <tbody>
        @foreach (var product in Model.Products)
        {
            <tr>
                <td>@product.Name</td>
                <td>@($"{product.Price:C}")</td>
                <td>
                    <a asp-page="Edit" asp-route-id="@product.Id">Edit</a> |
                    <a href="#" onclick="deleteProduct('@product.Id', antiForgeryToken())">Delete</a>
                </td>
            </tr>
        }
    </tbody>
</table>

<span id="spanError" class="text-danger"></span><br />

<a asp-page="./Create">Add Product</a>

@section Scripts
{
    <script src="~/js/product.js" asp-append-version="true"></script>
    <script language="javascript">
        const antiForgeryToken = () => '@Model.AntiforgeryToken';
    </script>
}