using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Carts
    {
       
        public string Size { get; set; }
        public decimal UnitPrice { get; set; }
        public short Quantity { get; set; }
        public int ProductId { get; set; }
        public int UserId { get; set; }

        public virtual Products Product { get; set; }
        public virtual Users User { get; set; }
    }
}
