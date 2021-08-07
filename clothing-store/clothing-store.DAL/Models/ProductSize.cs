using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class ProductSize
    {
        public int ProductId { get; set; }
        public int SizeId { get; set; }

        public virtual Products Product { get; set; }
        public virtual Size Size { get; set; }
    }
}
