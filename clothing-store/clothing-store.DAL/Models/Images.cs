using System;
using System.Collections.Generic;

namespace clothing_store.DAL.Models
{
    public partial class Images
    {
        public int ImageId { get; set; }
        public int ProductId { get; set; }
        public string ImageSource { get; set; }

        public virtual Products Product { get; set; }
    }
}
