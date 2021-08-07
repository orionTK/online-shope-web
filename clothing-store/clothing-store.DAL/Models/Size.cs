using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Size
    {
        public Size()
        {
            ProductSize = new HashSet<ProductSize>();
        }

        public int SizeId { get; set; }
        public string SizeName { get; set; }

        public virtual ICollection<ProductSize> ProductSize { get; set; }
    }
}
