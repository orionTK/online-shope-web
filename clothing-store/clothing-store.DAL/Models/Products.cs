using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Products
    {
        public Products()
        {
            Carts = new HashSet<Carts>();
            OrderDetails = new HashSet<OrderDetails>();
            ProductSize = new HashSet<ProductSize>();
        }

        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        public string ProductName { get; set; }
        public decimal Price { get; set; }
        public short Stock { get; set; }
        public DateTime DateCreate { get; set; }
        public string Description { get; set; }
        public string ImageSource { get; set; }
        public int? PromotionId { get; set; }

        public virtual Categories Category { get; set; }
        public virtual Promotion Promotion { get; set; }
        public virtual ICollection<Carts> Carts { get; set; }
        public virtual ICollection<OrderDetails> OrderDetails { get; set; }
        public virtual ICollection<ProductSize> ProductSize { get; set; }
    }
}
